/**
 * API local empaquetada en el APK.
 * Intercepta fetch() y responde con datos de data/store.json + localStorage.
 */
(function () {
    if (!window.USE_LOCAL_API) return;

    const MUT_KEY = 'pdi_offline_mutations';
    const _fetch  = window.fetch.bind(window);
    let baseStore = null;
    let working   = null;

    function dataPath() {
        return window.location.pathname.includes('/html/')
            ? '../data/store.json'
            : 'data/store.json';
    }

    function defaultMutations() {
        return {
            resenas: [],
            promociones: [],
            pdis_nuevos: [],
            pdis_editados: {},
            pdis_eliminados: [],
            usuarios_cliente: [],
            usuarios_vendedor: [],
        };
    }

    function getMutations() {
        try {
            const m = JSON.parse(localStorage.getItem(MUT_KEY) || 'null');
            return m ? { ...defaultMutations(), ...m } : defaultMutations();
        } catch {
            return defaultMutations();
        }
    }

    function saveMutations(m) {
        localStorage.setItem(MUT_KEY, JSON.stringify(m));
        rebuildWorking();
    }

    async function loadBase() {
        if (baseStore) return baseStore;
        const res = await _fetch(dataPath());
        if (!res.ok) throw new Error('No se pudo cargar data/store.json');
        baseStore = await res.json();
        rebuildWorking();
        return baseStore;
    }

    function rebuildWorking() {
        if (!baseStore) return;
        const m = getMutations();

        working = {
            pdi: baseStore.pdi
                .filter(p => !m.pdis_eliminados.includes(p.id_pdi))
                .map(p => ({ ...p, ...(m.pdis_editados[p.id_pdi] || {}) }))
                .concat(m.pdis_nuevos),
            opiniones: [...baseStore.opiniones_y_calificaciones, ...m.resenas],
            promociones: [...baseStore.promocion_punto, ...m.promociones],
            usuario_admin: [...baseStore.usuario_admin],
            usuario_cliente: [...baseStore.usuario_cliente, ...m.usuarios_cliente],
            usuario_vendedor: [...baseStore.usuario_vendedor, ...m.usuarios_vendedor],
        };
    }

    function jsonRes(data, status = 200) {
        return new Response(JSON.stringify(data), {
            status,
            headers: { 'Content-Type': 'application/json' },
        });
    }

    function parseUrl(url) {
        const u = new URL(url, window.location.origin);
        return {
            endpoint: u.pathname.split('/').pop(),
            params: Object.fromEntries(u.searchParams.entries()),
        };
    }

    function promoActiva(idPdi) {
        const id = parseInt(idPdi, 10);
        const now = Date.now();
        return working.promociones
            .filter(p => parseInt(p.id_pdi, 10) === id)
            .filter(p => new Date(p.fecha_inicio) <= now && new Date(p.fecha_fin) >= now)
            .sort((a, b) => new Date(b.fecha_inicio) - new Date(a.fecha_inicio))[0] || null;
    }

    function nextId(list, key) {
        const ids = list.map(x => x[key]).filter(Boolean);
        return ids.length ? Math.max(...ids) + 1 : 1;
    }

    async function handle(endpoint, method, params, body) {
        await loadBase();

        switch (endpoint) {

            case 'pois.php': {
                let list = working.pdi.map(p => ({
                    ...p,
                    latitud: parseFloat(p.latitud),
                    longitud: parseFloat(p.longitud),
                    tiene_promo: !!promoActiva(p.id_pdi),
                }));
                const cat = params.categoria;
                if (cat && cat !== 'Todos') {
                    list = list.filter(p => p.categoria === cat);
                }
                return jsonRes(list);
            }

            case 'login.php': {
                const tablas = [
                    ['usuario_cliente', 'id_cliente'],
                    ['usuario_admin', 'id_admin'],
                    ['usuario_vendedor', 'id_vendedor'],
                ];
                for (const [tabla, idKey] of tablas) {
                    const u = working[tabla].find(x => x.email === body.email && x.password === body.password);
                    if (u) {
                        const usuario = { ...u };
                        delete usuario.password;
                        usuario.rol = tabla;
                        return jsonRes({ ok: true, usuario });
                    }
                }
                return jsonRes({ error: 'Credenciales incorrectas' }, 401);
            }

            case 'registrar.php': {
                const email = (body.email || '').trim();
                for (const t of ['usuario_cliente', 'usuario_admin', 'usuario_vendedor']) {
                    if (working[t].some(u => u.email === email)) {
                        return jsonRes({ error: 'El correo ya está registrado' }, 409);
                    }
                }
                const m = getMutations();
                if (body.es_vendedor) {
                    const nuevo = {
                        id_vendedor: nextId([...working.usuario_vendedor, ...m.usuarios_vendedor], 'id_vendedor'),
                        nombre: body.nombre,
                        email,
                        password: body.password,
                        fecha_registro: new Date().toISOString().slice(0, 19).replace('T', ' '),
                        id_admin: 1,
                    };
                    m.usuarios_vendedor.push(nuevo);
                } else {
                    const nuevo = {
                        id_cliente: nextId([...working.usuario_cliente, ...m.usuarios_cliente], 'id_cliente'),
                        nombre: body.nombre,
                        apellidos: body.apellidos || '',
                        email,
                        password: body.password,
                        fecha_registro: new Date().toISOString().slice(0, 19).replace('T', ' '),
                        id_admin: 1,
                    };
                    m.usuarios_cliente.push(nuevo);
                }
                saveMutations(m);
                const rol = body.es_vendedor ? 'vendedor' : 'cliente';
                return jsonRes({ ok: true, mensaje: 'Registro exitoso', rol });
            }

            case 'resenas.php': {
                if (method === 'GET') {
                    const idPdi = parseInt(params.id_pdi, 10);
                    const resenas = working.opiniones
                        .filter(o => o.id_pdi === idPdi)
                        .map(o => {
                            const c = working.usuario_cliente.find(x => x.id_cliente === o.id_cliente);
                            return {
                                id_opinion: o.id_opinion,
                                puntuacion: o.puntuacion,
                                comentario: o.comentario,
                                fecha: o.fecha,
                                usuario: c ? c.nombre : 'Usuario',
                            };
                        })
                        .sort((a, b) => new Date(b.fecha) - new Date(a.fecha));
                    const promedio = resenas.length
                        ? Math.round(resenas.reduce((s, r) => s + r.puntuacion, 0) / resenas.length * 10) / 10
                        : 0;
                    return jsonRes({ resenas, promedio, total: resenas.length });
                }
                const m = getMutations();
                const nueva = {
                    id_opinion: nextId([...working.opiniones, ...m.resenas], 'id_opinion'),
                    puntuacion: body.puntuacion,
                    comentario: body.comentario || '',
                    fecha: new Date().toISOString().slice(0, 19).replace('T', ' '),
                    id_cliente: body.id_cliente,
                    id_pdi: body.id_pdi,
                };
                m.resenas.push(nueva);
                saveMutations(m);
                return jsonRes({ ok: true, mensaje: 'Reseña guardada' });
            }

            case 'promociones.php': {
                const idPdi = parseInt(params.id_pdi, 10);
                const promo = promoActiva(idPdi);
                if (!promo) return jsonRes({ error: 'No hay promociones activas para este punto' }, 404);
                const pdi = working.pdi.find(p => p.id_pdi === idPdi);
                return jsonRes({
                    ...promo,
                    nombre_pdi: pdi?.nombre,
                    categoria: pdi?.categoria,
                    direccion: pdi?.direccion,
                });
            }

            case 'mis_pois.php': {
                const idVend = parseInt(params.id_vendedor, 10);
                const pois = working.pdi
                    .filter(p => p.id_vendedor === idVend)
                    .map(p => ({
                        id_pdi: parseInt(p.id_pdi, 10),
                        nombre: p.nombre,
                        categoria: p.categoria,
                        direccion: p.direccion,
                    }));
                return jsonRes(pois);
            }

            case 'crear_promocion.php': {
                const m = getMutations();
                const nueva = {
                    id_promocion: nextId([...working.promociones, ...m.promociones], 'id_promocion'),
                    nombre: body.nombre,
                    informacion: body.informacion || '',
                    fecha_inicio: body.fecha_inicio,
                    fecha_fin: body.fecha_fin,
                    id_vendedor: body.id_vendedor,
                    id_pdi: body.id_pdi,
                };
                m.promociones.push(nueva);
                saveMutations(m);
                return jsonRes({ ok: true, mensaje: 'Promoción publicada exitosamente', id_promocion: nueva.id_promocion, id_pdi: body.id_pdi });
            }

            case 'pdi_por_id.php': {
                const id = parseInt(params.id_pdi, 10);
                const pdi = working.pdi.find(p => p.id_pdi === id);
                if (!pdi) return jsonRes({ error: 'No se encontró ningún punto con ese ID' }, 404);
                return jsonRes({
                    ...pdi,
                    id_pdi: parseInt(pdi.id_pdi, 10),
                    latitud: parseFloat(pdi.latitud),
                    longitud: parseFloat(pdi.longitud),
                });
            }

            case 'registrar_pdi.php': {
                const m = getMutations();
                const id = nextId([...working.pdi, ...m.pdis_nuevos], 'id_pdi');
                m.pdis_nuevos.push({
                    id_pdi: id,
                    nombre: body.nombre,
                    categoria: body.categoria,
                    descripcion: body.descripcion || '',
                    direccion: body.direccion || '',
                    latitud: body.latitud,
                    longitud: body.longitud,
                    foto: body.foto || '',
                    id_vendedor: body.id_vendedor || null,
                    id_admin: body.id_admin,
                });
                saveMutations(m);
                return jsonRes({ ok: true, mensaje: 'Punto registrado exitosamente', id_pdi: id });
            }

            case 'editar_pdi.php': {
                const m = getMutations();
                const id = body.id_pdi;
                const datos = {
                    nombre: body.nombre,
                    categoria: body.categoria,
                    descripcion: body.descripcion || '',
                    direccion: body.direccion || '',
                    latitud: body.latitud,
                    longitud: body.longitud,
                    foto: body.foto || '',
                    id_vendedor: body.id_vendedor || null,
                    id_admin: body.id_admin,
                };
                if (m.pdis_nuevos.some(p => p.id_pdi === id)) {
                    m.pdis_nuevos = m.pdis_nuevos.map(p => p.id_pdi === id ? { ...p, ...datos, id_pdi: id } : p);
                } else {
                    m.pdis_editados[id] = datos;
                }
                saveMutations(m);
                return jsonRes({ ok: true, mensaje: 'Punto actualizado exitosamente', id_pdi: id });
            }

            case 'eliminar_pdi.php': {
                const m = getMutations();
                const id = body.id_pdi;
                m.pdis_nuevos = m.pdis_nuevos.filter(p => p.id_pdi !== id);
                delete m.pdis_editados[id];
                if (!m.pdis_eliminados.includes(id)) m.pdis_eliminados.push(id);
                saveMutations(m);
                return jsonRes({ ok: true, mensaje: 'Punto eliminado correctamente junto con sus reseñas y promociones' });
            }

            default:
                return jsonRes({ error: 'Endpoint no disponible offline' }, 404);
        }
    }

    window.fetch = async function (url, options = {}) {
        const urlStr = url.toString();
        if (!/\.php/.test(urlStr)) return _fetch(url, options);

        const { endpoint, params } = parseUrl(urlStr);
        const method = (options.method || 'GET').toUpperCase();
        let body = null;
        if (options.body) {
            try { body = JSON.parse(options.body); } catch { body = null; }
        }

        try {
            return await handle(endpoint, method, params, body);
        } catch (e) {
            console.error('Local API error:', e);
            return jsonRes({ error: e.message }, 500);
        }
    };

    console.log('[PDI] API local activa — sin servidor remoto');
})();

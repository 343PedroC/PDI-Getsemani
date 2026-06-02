const API = "api"; //constante api para el archivo main.js

// ── MAPA ─────────────────────────────────────────────────────────────────────
const mapa = L.map('mapa', { zoomControl: false }).setView([10.421068, -75.546222], 16);
L.control.zoom({ position: 'topright' }).addTo(mapa);

let marcadores = [];
let filtroPromoActivo = false;

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(mapa);

// ── COLORES POR CATEGORÍA ─────────────────────────────────────────────────────
const colores = {
    Restaurante:    "#2A81CB",
    Bar:            "#CB2B3E",
    Tienda:         "#2AAD27",
    Café:           "#CB8427",
    Hostal:         "#9C2BCB",
    Licorería:      "#3D3D3D",
    Hotel:          "#E84393",
    "Casa de Cambio": "#00BFAE",
    default:        "#CAC428"
};

function getRadio() {
    const z = mapa.getZoom();
    if (z >= 18) return 10;
    if (z >= 17) return 8;
    if (z >= 16) return 6;
    return 5;
}

mapa.on('zoomend', () => {
    const r = getRadio();
    marcadores.forEach(item => item.marcador.setRadius(r));
});

// ── ESTRELLAS ─────────────────────────────────────────────────────────────────
function generarEstrellas(n) {
    let s = "";
    for (let i = 1; i <= 5; i++) s += i <= n ? "⭐" : "☆";
    return s;
}

// ── POPUP ─────────────────────────────────────────────────────────────────────
// caché en memoria para no re-pedir al servidor en cada apertura
const cachePDI = {};

async function construirPopup(punto) {
    let promedio = 0;
    let total    = 0;

    if (cachePDI[punto.id_pdi] !== undefined) {
        ({ promedio, total } = cachePDI[punto.id_pdi]);
    } else {
        try {
            const res  = await fetch(`${API}/resenas.php?id_pdi=${punto.id_pdi}`);
            const data = await res.json();
            promedio = data.promedio;
            total    = data.total;
            cachePDI[punto.id_pdi] = { promedio, total };
        } catch (_) { /* sin conexión: muestra sin calificación */ }
    }

    const calificacionHTML = total > 0
        ? `${generarEstrellas(Math.round(promedio))} <span style="font-size:12px;color:#777">(${total})</span>`
        : `<span style="color:#aaa;font-size:13px;">Sin calificaciones aún</span>`;

    // Enlace de promoción: solo aparece si el PDI tiene una promo activa
    const promoHTML = punto.tiene_promo
        ? `<div class="popup-promo-link">
               <a href="html/promociones.html?id_pdi=${punto.id_pdi}"
                  class="btn-promo-enlace">🏷️ ¡Ver promoción activa!</a>
           </div>`
        : '';

    return `
        <h3>${punto.nombre}</h3>
        <p><b>Tipo:</b> ${punto.categoria}</p>
        <p><b>Dirección:</b> ${punto.direccion}</p>
        <p><strong>Coordenadas:</strong><br>
           Lat: ${parseFloat(punto.latitud).toFixed(6)}<br>
           Lon: ${parseFloat(punto.longitud).toFixed(6)}</p>
        <img src="${punto.foto}" alt="${punto.nombre}">
        <p><strong>Calificación promedio:</strong><br>${calificacionHTML}</p>
        ${promoHTML}
        <div style="text-align:right;margin-top:10px;">
            <a href="html/calificar.html?id_pdi=${punto.id_pdi}&nombre=${encodeURIComponent(punto.nombre)}"
               style="margin-right:10px;">⭐ Calificar</a>
            <a href="html/resenas.html?id_pdi=${punto.id_pdi}&nombre=${encodeURIComponent(punto.nombre)}">💬 Reseñas</a>
        </div>
        <div style="text-align:center;margin-top:10px;padding-top:8px;border-top:1px solid #eee;">
            <button onclick="window.trazarRutaPopup(${punto.latitud}, ${punto.longitud}, ${JSON.stringify(punto.nombre).replace(/"/g, '&quot;')})"
                    class="btn-como-llegar">🚶 Cómo llegar</button>
        </div>
    `;
}

// ── FILTRO PROMO (client-side) ────────────────────────────────────────────────
function aplicarFiltroPromo() {
    marcadores.forEach(item => {
        if (filtroPromoActivo && !item.punto.tiene_promo) {
            mapa.removeLayer(item.marcador);
        } else {
            item.marcador.addTo(mapa);
        }
    });
}

// ── CARGAR POIs ───────────────────────────────────────────────────────────────
async function cargarPOIs(categoria = "Todos") {
    // Limpia marcadores anteriores
    marcadores.forEach(item => mapa.removeLayer(item.marcador));
    marcadores = [];

    try {
        const url = categoria === "Todos"
            ? `${API}/pois.php`
            : `${API}/pois.php?categoria=${encodeURIComponent(categoria)}`;

        const res    = await fetch(url);
        const puntos = await res.json();

        for (const punto of puntos) {
            const color = colores[punto.categoria] || colores.default;
            const marcador = L.circleMarker([punto.latitud, punto.longitud], {
                radius:      getRadio(),
                fillColor:   color,
                color:       "#ffffff",
                weight:      1.5,
                opacity:     1,
                fillOpacity: 0.9
            });

            // Popup con placeholder mientras carga
            marcador.bindPopup("<p style='text-align:center'>Cargando...</p>");

            marcador.on("popupopen", async () => {
                delete cachePDI[punto.id_pdi];
                const html = await construirPopup(punto);
                marcador.getPopup().setContent(html);
            });

            marcadores.push({ tipo: punto.categoria, marcador, punto });
            marcador.addTo(mapa);
        }

        // Si el filtro de proximidad está activo, re-aplicarlo sobre los marcadores recién cargados
        if (filtroProximidadActivo) aplicarFiltroProximidad();

    } catch (e) {
        console.error("Error cargando POIs:", e);
    }
}

cargarPOIs();

// ── FILTROS DE CATEGORÍA ──────────────────────────────────────────────────────
// Usar [data-tipo] para excluir el botón de Promociones
document.querySelectorAll(".filtros button[data-tipo]").forEach(boton => {
    boton.addEventListener("click", () => {
        // Al seleccionar categoría, se desactiva el filtro de promos
        filtroPromoActivo = false;
        document.getElementById('btn-promo-filtro')?.classList.remove('activo');
        cargarPOIs(boton.dataset.tipo);
    });
});

// ── FILTRO PROMOCIONES ────────────────────────────────────────────────────────
document.getElementById('btn-promo-filtro')?.addEventListener('click', () => {
    filtroPromoActivo = !filtroPromoActivo;
    document.getElementById('btn-promo-filtro').classList.toggle('activo', filtroPromoActivo);
    aplicarFiltroPromo();
    // Limpiar búsqueda activa al cambiar filtro
    const input = document.getElementById('search-input');
    const msg   = document.getElementById('search-message');
    if (input) input.value = '';
    if (msg)   msg.style.display = 'none';
});

// ── SESIÓN ────────────────────────────────────────────────────────────────────
const btnLogin = document.getElementById("btn-login");
const usuario  = JSON.parse(localStorage.getItem("usuarioActivo"));

if (usuario) {
    btnLogin.textContent = `${usuario.nombre} · Salir`;
    btnLogin.addEventListener("click", () => {
        localStorage.removeItem("usuarioActivo");
        location.reload();
    });
} else {
    btnLogin.textContent = "Iniciar sesión";
    btnLogin.addEventListener("click", () => {
        window.location.href = "html/login.html";
    });
}

// ── BOTÓN VENDEDOR (solo rol usuario_vendedor) ────────────────────────────────
const btnVendedor = document.getElementById("btn-vendedor");
if (usuario?.rol === "usuario_vendedor") {
    btnVendedor.style.display = "block";
}
btnVendedor?.addEventListener("click", () => {
    window.location.href = "html/promocionar.html";
});

// ── BOTÓN ADMIN (solo rol usuario_admin) ──────────────────────────────────────
const btnAdmin = document.getElementById("btn-admin");
if (usuario?.rol === "usuario_admin") {
    btnAdmin.style.display = "block";
}
btnAdmin?.addEventListener("click", () => {
    window.location.href = "html/panel_admin.html";
});

// ── BÚSQUEDA ─────────────────────────────────────────────────────────────────
const BusquedaControl = L.Control.extend({
    options: { position: 'topleft' },
    onAdd(map) {
        const container = L.DomUtil.create('div', 'search-control');
        container.innerHTML = `
            <div class="search-wrapper">
                <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <circle cx="11" cy="11" r="7"/>
                    <line x1="16.5" y1="16.5" x2="22" y2="22"/>
                </svg>
                <input type="text" id="search-input" placeholder="¿A dónde quieres ir?..." autocomplete="off">
                <button id="search-clear" class="search-clear" title="Limpiar">✕</button>
            </div>
            <div id="search-message" class="search-message"></div>
        `;
        L.DomEvent.disableClickPropagation(container);
        L.DomEvent.disableScrollPropagation(container);
        return container;
    }
});
new BusquedaControl().addTo(mapa);

// Enter → ejecutar búsqueda
document.addEventListener('keydown', e => {
    if (e.target?.id === 'search-input' && e.key === 'Enter')
        buscarPunto(e.target.value.trim());
});

// ✕ → limpiar búsqueda
document.addEventListener('click', e => {
    if (e.target?.id === 'search-clear') {
        const input = document.getElementById('search-input');
        if (input) { input.value = ''; input.focus(); }
        limpiarBusqueda();
    }
});

// Al cambiar filtro de categoría, limpiar el input y mensaje de búsqueda
document.querySelectorAll('.filtros button[data-tipo]').forEach(boton => {
    boton.addEventListener('click', () => {
        const input = document.getElementById('search-input');
        const msg   = document.getElementById('search-message');
        if (input) input.value = '';
        if (msg)   msg.style.display = 'none';
    });
});

function buscarPunto(query) {
    const msg = document.getElementById('search-message');
    if (!query) { limpiarBusqueda(); return; }

    const ql = query.toLowerCase();

    // Si el filtro de promos está activo, buscar solo dentro de esos marcadores
    const base = filtroPromoActivo
        ? marcadores.filter(item => item.punto.tiene_promo)
        : marcadores;

    // Búsqueda primero por categoría, luego por nombre
    let encontrados = base.filter(item =>
        item.punto.categoria.toLowerCase().includes(ql)
    );
    if (encontrados.length === 0) {
        encontrados = base.filter(item =>
            item.punto.nombre.toLowerCase().includes(ql)
        );
    }

    // Ocultar todos los marcadores actuales
    marcadores.forEach(item => mapa.removeLayer(item.marcador));

    if (encontrados.length === 0) {
        msg.innerHTML = `<span>⚠️ Sin resultados para <strong>"${query}"</strong>.</span>`;
        msg.style.display = 'block';
    } else {
        encontrados.forEach(item => item.marcador.addTo(mapa));
        msg.style.display = 'none';
        if (encontrados.length === 1) {
            const { marcador, punto } = encontrados[0];
            mapa.setView([punto.latitud, punto.longitud], 18);
            marcador.openPopup();
        } else {
            const grupo = L.featureGroup(encontrados.map(i => i.marcador));
            mapa.fitBounds(grupo.getBounds().pad(0.3));
        }
    }
}

function limpiarBusqueda() {
    const msg = document.getElementById('search-message');
    if (msg) msg.style.display = 'none';
    // Si la proximidad está activa tiene prioridad; si no, respetar filtro de promos
    if (filtroProximidadActivo) {
        aplicarFiltroProximidad();
    } else {
        aplicarFiltroPromo();
    }
}

// ── GEOLOCALIZACIÓN Y PROXIMIDAD ──────────────────────────────────────────────

// ↓ Intervalo entre capturas de ubicación (en milisegundos). Modifica este valor a voluntad.
const INTERVALO_UBICACION_MS = 60000; // 60 segundos

// Radio en metros para mostrar puntos cercanos cuando el usuario está en Getsemaní
const RADIO_PROXIMIDAD_M = 150;

// Bounding box aproximado del barrio Getsemaní. Si el usuario cae fuera de estos límites
// se considera que no está en el barrio y se muestran TODOS los puntos.
const BOUNDS_GETSEMANI = {
    latMin: 10.413, latMax: 10.428,
    lonMin: -75.558, lonMax: -75.537
};

let ubicacionUsuario       = null;
let marcadorUsuario        = null;
let circuloProximidad      = null;
let filtroProximidadActivo = false;

// Distancia en metros entre dos coordenadas (fórmula Haversine)
function haversine(lat1, lon1, lat2, lon2) {
    const R    = 6371000;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a    = Math.sin(dLat / 2) ** 2 +
                 Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                 Math.sin(dLon / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

function estaEnGetsemani(lat, lon) {
    return lat >= BOUNDS_GETSEMANI.latMin && lat <= BOUNDS_GETSEMANI.latMax &&
           lon >= BOUNDS_GETSEMANI.lonMin && lon <= BOUNDS_GETSEMANI.lonMax;
}

function aplicarFiltroProximidad() {
    if (!ubicacionUsuario || !filtroProximidadActivo) return;
    const { lat, lon } = ubicacionUsuario;
    marcadores.forEach(item => {
        const dist = haversine(lat, lon, item.punto.latitud, item.punto.longitud);
        if (dist <= RADIO_PROXIMIDAD_M) {
            item.marcador.addTo(mapa);
        } else {
            mapa.removeLayer(item.marcador);
        }
    });
}

async function actualizarUbicacion(pos) {
    const lat = pos.coords.latitude;
    const lon = pos.coords.longitude;
    ubicacionUsuario = { lat, lon };

    // Actualizar o crear el punto azul que representa al usuario
    if (marcadorUsuario) {
        marcadorUsuario.setLatLng([lat, lon]);
    } else {
        marcadorUsuario = L.marker([lat, lon], {
            icon: L.divIcon({
                html: '<span style="font-size:22px;line-height:1;filter:drop-shadow(0 1px 2px rgba(0,0,0,0.4))">🚶</span>',
                className: '',
                iconSize:   [22, 22],
                iconAnchor: [11, 22]
            }),
            zIndexOffset: 1000
        }).bindTooltip("Tu ubicación", { permanent: false, direction: "top" }).addTo(mapa);
    }

    if (estaEnGetsemani(lat, lon)) {
        filtroProximidadActivo = true;

        // Actualizar o crear el círculo de radio de proximidad
        if (circuloProximidad) {
            circuloProximidad.setLatLng([lat, lon]);
        } else {
            circuloProximidad = L.circle([lat, lon], {
                radius:      RADIO_PROXIMIDAD_M,
                color:       "#1e90ff",
                weight:      1.5,
                opacity:     0.5,
                fillColor:   "#1e90ff",
                fillOpacity: 0.06
            }).addTo(mapa);
        }

        aplicarFiltroProximidad();

    } else {
        // El usuario está fuera de Getsemaní: mostrar TODOS los puntos sin excepción
        filtroProximidadActivo = false;
        if (circuloProximidad) {
            mapa.removeLayer(circuloProximidad);
            circuloProximidad = null;
        }
        await cargarPOIs("Todos");
    }
}

function iniciarGeolocalizacion() {
    if (!navigator.geolocation) {
        console.warn("Este navegador no soporta geolocalización.");
        return;
    }

    const opciones = { enableHighAccuracy: true, timeout: 10000 };

    const capturar = () => {
        navigator.geolocation.getCurrentPosition(
            actualizarUbicacion,
            err => console.warn("Geolocalización no disponible:", err.message),
            opciones
        );
    };

    capturar(); // Primera captura inmediata al cargar la página
    setInterval(capturar, INTERVALO_UBICACION_MS);
}

iniciarGeolocalizacion();

// ── ENRUTAMIENTO PEATONAL ─────────────────────────────────────────────────────

let controlRuta = null;

// Expone la función globalmente para que los botones dentro de popups (HTML string) puedan llamarla
window.trazarRutaPopup = (lat, lon, nombre) => trazarRuta(lat, lon, nombre);

function trazarRuta(destLat, destLon, nombre) {
    if (!ubicacionUsuario) {
        const msg = document.getElementById('search-message');
        if (msg) {
            msg.innerHTML = '<span>⚠️ Activa la ubicación en tu navegador para trazar una ruta.</span>';
            msg.style.display = 'block';
        }
        return;
    }

    cancelarRuta();

    const { lat, lon } = ubicacionUsuario;

    controlRuta = L.Routing.control({
        waypoints: [
            L.latLng(lat, lon),
            L.latLng(destLat, destLon)
        ],
        router: L.Routing.osrmv1({
            serviceUrl: 'https://router.project-osrm.org/route/v1',
            profile: 'foot'
        }),
        lineOptions: {
            styles: [{ color: '#1e90ff', opacity: 0.85, weight: 5 }],
            extendToWaypoints: false,
            missingRouteTolerance: 0
        },
        show: false,
        addWaypoints: false,
        routeWhileDragging: false,
        fitSelectedRoutes: true,
        createMarker: () => null  // no usar los marcadores propios de LRM
    }).addTo(mapa);

    controlRuta.on('routesfound', e => {
        const ruta    = e.routes[0];
        const distM   = ruta.summary.totalDistance;
        const timeS   = ruta.summary.totalTime;

        const distTexto = distM >= 1000
            ? `${(distM / 1000).toFixed(1)} km`
            : `${Math.round(distM)} m`;
        const minutos = Math.ceil(timeS / 60);

        mostrarInfoRuta(nombre, distTexto, minutos);
    });

    controlRuta.on('routingerror', () => {
        const msg = document.getElementById('search-message');
        if (msg) {
            msg.innerHTML = '<span>⚠️ No se pudo calcular la ruta. Verifica tu conexión a internet.</span>';
            msg.style.display = 'block';
        }
        cancelarRuta();
    });
}

function mostrarInfoRuta(nombre, distTexto, minutos) {
    let div = document.getElementById('ruta-info');
    if (!div) {
        div = document.createElement('div');
        div.id = 'ruta-info';
        document.getElementById('mapa').appendChild(div);
    }
    div.innerHTML = `
        <span class="ruta-destino">🏁 ${nombre}</span>
        <span class="ruta-datos">📍 ${distTexto}&nbsp;&nbsp;·&nbsp;&nbsp;🚶 ~${minutos} min</span>
        <button id="btn-cancelar-ruta" class="ruta-cancelar" title="Cancelar ruta">✕</button>
    `;
    div.style.display = 'flex';
    document.getElementById('btn-cancelar-ruta').addEventListener('click', cancelarRuta);
}

function cancelarRuta() {
    if (controlRuta) {
        mapa.removeControl(controlRuta);
        controlRuta = null;
    }
    const info = document.getElementById('ruta-info');
    if (info) info.remove();
}
const API = "api"; //constante api para el archivo main.js

// ── MAPA ─────────────────────────────────────────────────────────────────────
const mapa = L.map('mapa', { zoomControl: false }).setView([10.421068, -75.546222], 16);
L.control.zoom({ position: 'topright' }).addTo(mapa);

let marcadores = [];
let filtroPromoActivo = false;

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(mapa);

// ── ICONOS ───────────────────────────────────────────────────────────────────
const iconos = {
    Restaurante: L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png" }),
    Bar:         L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png" }),
    Tienda:      L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png" }),
    Café:        L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-orange.png" }),
    Hostal:      L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-violet.png" }),
    Licorería:   L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-black.png" }),
    default:     L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-yellow.png" })
};

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
            const marcador = L.marker([punto.latitud, punto.longitud], {
                icon: iconos[punto.categoria] || iconos.default
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
                <input type="text" id="search-input" placeholder="Buscar punto de interés..." autocomplete="off">
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
    // Respetar el filtro de promos al limpiar la búsqueda
    aplicarFiltroPromo();
}
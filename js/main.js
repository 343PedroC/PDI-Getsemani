const API = "api"; //constante api para el archivo main.js

// ── MAPA ─────────────────────────────────────────────────────────────────────
const mapa = L.map("mapa").setView([10.421068, -75.546222], 16);
let marcadores = [];

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(mapa);

// ── ICONOS ───────────────────────────────────────────────────────────────────
const iconos = {
    Comercio:  L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png" }),
    Patrimonio:L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png" }),
    Ambiente:  L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png" }),
    Vivienda:  L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-orange.png" }),
    default:   L.icon({ iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-gold.png" })
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
    let total = 0;

    // Solo pedimos al servidor si no lo tenemos en caché
    if (cachePDI[punto.id_pdi] !== undefined) {
        ({ promedio, total } = cachePDI[punto.id_pdi]);
    } else {
        try {
            const res = await fetch(`${API}/resenas.php?id_pdi=${punto.id_pdi}`);
            const data = await res.json();
            promedio = data.promedio;
            total    = data.total;
            cachePDI[punto.id_pdi] = { promedio, total };
        } catch (_) { /* sin conexión: muestra sin calificación */ }
    }

    const calificacionHTML = total > 0
        ? `${generarEstrellas(Math.round(promedio))} <span style="font-size:12px;color:#777">(${total})</span>`
        : `<span style="color:#aaa;font-size:13px;">Sin calificaciones aún</span>`;

    return `
        <h3>${punto.nombre}</h3>
        <p><b>Tipo:</b> ${punto.categoria}</p>
        <p><b>Dirección:</b> ${punto.direccion}</p>
        <p><strong>Coordenadas:</strong><br>
           Lat: ${parseFloat(punto.latitud).toFixed(6)}<br>
           Lon: ${parseFloat(punto.longitud).toFixed(6)}</p>
        <img src="${punto.foto}" alt="${punto.nombre}">
        <p><strong>Calificación promedio:</strong><br>${calificacionHTML}</p>
        <div style="text-align:right;margin-top:10px;">
            <a href="html/calificar.html?id_pdi=${punto.id_pdi}&nombre=${encodeURIComponent(punto.nombre)}" style="margin-right:10px;">⭐ Calificar</a>
            <a href="html/resenas.html?id_pdi=${punto.id_pdi}&nombre=${encodeURIComponent(punto.nombre)}">💬 Reseñas</a>
        </div>
    `;
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
                // Invalidamos caché del punto para mostrar datos frescos
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

// ── FILTROS ───────────────────────────────────────────────────────────────────
document.querySelectorAll(".filtros button").forEach(boton => {
    boton.addEventListener("click", () => {
        cargarPOIs(boton.dataset.tipo);
    });
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
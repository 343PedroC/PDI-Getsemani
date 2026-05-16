// Variables globales
const mapa = L.map('mapa').setView([10.421068, -75.546222], 16);//Estas son las coords donde aparce inicialmente el usuario y el nivel de zoom
let marcadores = [];

// Capa base de OpenStreetMap
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(mapa);

// Iconos personalizados por tipo
const iconos = {
    Comercio: L.icon({ iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png' }),
    Patrimonio: L.icon({ iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png' }),
    Ambiente: L.icon({ iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png' }),
    Vivienda: L.icon({ iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-orange.png' }),
    default: L.icon({ iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-gold.png' })
};

//Calificación
function generarEstrellas(calificacion) {
    let estrellas = "";
    for (let i = 1; i <= 5; i++) {
        estrellas += (i <= calificacion) ? "⭐" : "☆";
    }
    return estrellas;
}

// Calcula el promedio real de un punto leyendo sus reseñas desde localStorage. Si no hay reseñas todavía, devuelve 0.
function obtenerPromedio(nombrePunto) {
    const clave = `resenas_${nombrePunto}`;
    const resenas = JSON.parse(localStorage.getItem(clave)) || [];

    if (resenas.length === 0) return 0;

    const suma = resenas.reduce((acum, r) => acum + r.calificacion, 0);
    return Math.round(suma / resenas.length); //Redondeamos para mostrar estrellas enteras
}

// Construye el HTML del popup de un punto.
// Al tenerlo en una función separada, podemos llamarla
// tanto al crear el marcador como al volver a abrir el popup.
function construirPopup(punto) {
    const calificacionPromedio = obtenerPromedio(punto.Nombre);

    return `
        <h3>${punto.Nombre}</h3>

        <p><b>Tipo:</b> ${punto.Tipo}</p>
        <p><b>Dirección:</b> ${punto.Direccion}</p>

        <p><strong>Coordenadas:</strong><br>
        Lat: ${punto.Latitud.toFixed(6)}<br>
        Lon: ${punto.Longitud.toFixed(6)}</p>

        <img src="${punto.Foto}" alt="${punto.Nombre}">

        <p><strong>Calificación promedio:</strong><br>
        ${calificacionPromedio > 0
            ? generarEstrellas(calificacionPromedio)
            : '<span style="color:#aaa;font-size:13px;">Sin calificaciones aún</span>'
        }</p>

        <div style="text-align: right; margin-top: 10px;">
            <a href="html/calificar.html?nombre=${encodeURIComponent(punto.Nombre)}" style="margin-right: 10px;">⭐ Calificar punto</a>
            <a href="html/resenas.html?nombre=${encodeURIComponent(punto.Nombre)}">💬 Ver reseñas</a>
        </div>
    `;
}

// Cargar y mostrar POIs
fetch('data/pois.json')
    .then(response => response.json())
    .then(puntos => {
        puntos.forEach(punto => {

            const marcador = L.marker([punto.Latitud, punto.Longitud], {
                icon: iconos[punto.Tipo] || iconos.default
            }).bindPopup(construirPopup(punto)); // primera vez que se construye

            marcadores.push({
                tipo: punto.Tipo,
                marcador: marcador,
                punto: punto          // guardamos el objeto punto completo
            });

            marcador.addTo(mapa);
        });
    });

// Cada vez que el usuario abre un popup, reconstruimos su contenido
// desde cero leyendo localStorage. Así el promedio siempre está actualizado
// sin necesidad de recargar la página.
mapa.on('popupopen', (e) => {
    // Buscamos en nuestro array el marcador que corresponde al popup abierto
    const item = marcadores.find(m => m.marcador.getPopup() === e.popup);

    if (item) {
        // Reemplazamos el contenido con datos frescos de localStorage
        e.popup.setContent(construirPopup(item.punto));
    }
});

// Filtros
document.querySelectorAll('.filtros button').forEach(boton => {
    boton.addEventListener('click', () => {
        const tipo = boton.dataset.tipo;
        filtrarPorTipo(tipo);
    });
});

function filtrarPorTipo(tipo) {
    marcadores.forEach(item => {
        mapa.removeLayer(item.marcador);
        if (tipo === 'Todos' || item.tipo === tipo) {
            item.marcador.addTo(mapa);
        }
    });
}

// Boton iniciar sesion
document.getElementById("btn-login").addEventListener("click", () => {
    window.location.href = 'html/login.html';//
});

//login 
async function login(email, password) {
    const res = await fetch("http://localhost:3000/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ email, password })
    });

    const data = await res.json();

    if (data.token) {
        localStorage.setItem("token", data.token);
        alert("Login exitoso");
    } else {
        alert("Error al iniciar sesión");
    }
}

//...
const btnLogin = document.getElementById("btn-login");
const modal = document.getElementById("modal-login");
const cerrar = document.getElementById("cerrar-modal");

btnLogin.addEventListener("click", () => {
    modal.style.display = "flex";
});

cerrar.addEventListener("click", () => {
    modal.style.display = "none";
});

window.addEventListener("click", (e) => {
    if (e.target === modal) {
        modal.style.display = "none";
    }
});
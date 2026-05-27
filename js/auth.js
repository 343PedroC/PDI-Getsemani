const api = "/PDI_Getsemani/api" ; //constante api para el archivo auth.js

async function login(email, password) {
    try {
        const res = await fetch(`${api}/login.php`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email, password })
        });
 
        const data = await res.json();
 
        if (!res.ok) {
            alert(data.error || "Credenciales incorrectas");
            return;
        }
 
        localStorage.setItem("usuarioActivo", JSON.stringify(data.usuario));
        alert("¡Bienvenido, " + data.usuario.nombre + "!");
        window.location.href = "../mapa.html";
 
    } catch (e) {
        alert("Error de conexión con el servidor");
        console.error(e);
    }
}
 
async function registrar(nombre, apellidos, email, password, es_vendedor = false) {
    try {
        const res = await fetch(`${api}/registrar.php`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ nombre, apellidos, email, password, es_vendedor })
        });
 
        const data = await res.json();
 
        if (!res.ok) {
            alert(data.error || "Error al registrar");
            return;
        }
 
        alert("Registro exitoso. Inicia sesión.");
        window.location.href = "login.html";
 
    } catch (e) {
        alert("Error de conexión con el servidor");
        console.error(e);
    }
}
 
function cerrarSesion() {
    localStorage.removeItem("usuarioActivo");
    window.location.href = "../mapa.html";
}
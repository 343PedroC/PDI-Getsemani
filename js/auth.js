async function login(email, password) {
    const response = await fetch('../data/usuarios.json');
    const usuariosBase = await response.json();

    let usuariosLocal = JSON.parse(localStorage.getItem('usuarios')) || [];

    const todosUsuarios = [...usuariosBase, ...usuariosLocal];

    const usuario = todosUsuarios.find(u => 
        u.email === email && u.password === password
    );

    if (usuario) {
        localStorage.setItem('usuarioActivo', JSON.stringify(usuario));
        alert("Login exitoso");
        window.location.href = "../mapa.html";
    } else {
        alert("Credenciales incorrectas");
    }
}

async function registrar(nombre, apellidos, email, password) {
    // obtener usuarios existentes del JSON
    const response = await fetch('../data/usuarios.json');
    const usuariosBase = await response.json();

    // obtener usuarios guardados en localStorage
    let usuariosLocal = JSON.parse(localStorage.getItem('usuarios')) || [];

    // combinar ambos
    const todosUsuarios = [...usuariosBase, ...usuariosLocal];

    // validar si ya existe
    const existe = todosUsuarios.find(u => u.email === email);

    if (existe) {
        alert("El usuario ya existe");
        return;
    }

    // crear nuevo usuario
    const nuevoUsuario = {
        id: Date.now(),
        nombre,
        apellidos,
        email,
        password
    };

    usuariosLocal.push(nuevoUsuario);

    // guardar en localStorage
    localStorage.setItem('usuarios', JSON.stringify(usuariosLocal));

    alert("Registro exitoso");

    // redirigir al login
    window.location.href = "login.html";
}
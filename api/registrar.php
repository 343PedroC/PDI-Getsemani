<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once "db.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    echo json_encode(["error" => "Método no permitido"]);
    exit;
}

$body       = json_decode(file_get_contents("php://input"), true);
$nombre     = trim($body["nombre"]    ?? "");
$apellidos  = trim($body["apellidos"] ?? "");
$email      = trim($body["email"]     ?? "");
$password   = trim($body["password"]  ?? "");
$esVendedor = isset($body["es_vendedor"]) && $body["es_vendedor"] === true; // true | false

if (!$nombre || !$email || !$password) {
    http_response_code(400);
    echo json_encode(["error" => "Nombre, email y contraseña son requeridos"]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(["error" => "Email inválido"]);
    exit;
}

if (strlen($password) < 6) {
    http_response_code(400);
    echo json_encode(["error" => "La contraseña debe tener mínimo 6 caracteres"]);
    exit;
}

try {
    $pdo = getDB();

    // Verificar si el email ya existe en cualquier tabla
    foreach (["usuario_cliente", "usuario_admin", "usuario_vendedor"] as $tabla) {
        $col = match($tabla) {
            "usuario_cliente"  => "id_cliente",
            "usuario_admin"    => "id_admin",
            "usuario_vendedor" => "id_vendedor"
        };
        $stmt = $pdo->prepare("SELECT $col FROM $tabla WHERE email = ? LIMIT 1");
        $stmt->execute([$email]);
        if ($stmt->fetch()) {
            http_response_code(409);
            echo json_encode(["error" => "El correo ya está registrado"]);
            exit;
        }
    }

    //$hash = password_hash($password, PASSWORD_BCRYPT); eso era para encriptacion. Este proyecto no estan profesional.
    //Dejado como comentario para un futuro

    if ($esVendedor) {
        // Vendedor: no tiene apellidos en el schema
        $stmt = $pdo->prepare("
            INSERT INTO usuario_vendedor (nombre, email, password, id_admin)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$nombre, $email, $password, 1]); //$hash en el ultimo campo
    } else {
        $stmt = $pdo->prepare("
            INSERT INTO usuario_cliente (nombre, apellidos, email, password, id_admin)
            VALUES (?, ?, ?, ?, ?)
        ");
        $stmt->execute([$nombre, $apellidos, $email, $password, 1]);
    }

    $rol = $esVendedor ? "vendedor" : "cliente";
    echo json_encode(["ok" => true, "mensaje" => "Registro exitoso", "rol" => $rol]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>
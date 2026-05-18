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

$body     = json_decode(file_get_contents("php://input"), true);
$nombre   = trim($body["nombre"]   ?? "");
$apellidos= trim($body["apellidos"]?? "");
$email    = trim($body["email"]    ?? "");
$password = trim($body["password"] ?? "");

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

    // Verificar si el email ya existe en cualquier tabla de usuarios
    foreach (["usuario_cliente", "usuario_admin", "usuario_vendedor"] as $tabla) {
        $stmt = $pdo->prepare("SELECT id_cliente FROM $tabla WHERE email = ? LIMIT 1");
        // Ajustamos la columna PK según la tabla
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

    $stmt = $pdo->prepare("
        INSERT INTO usuario_cliente (nombre, apellidos, email, password)
        VALUES (?, ?, ?, ?)
    ");
    $stmt->execute([$nombre, $apellidos, $email, $password]); //$hash en el ultimo campo

    echo json_encode(["ok" => true, "mensaje" => "Registro exitoso"]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

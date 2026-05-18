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

$body = json_decode(file_get_contents("php://input"), true);
$email    = trim($body["email"]    ?? "");
$password = trim($body["password"] ?? "");

if (!$email || !$password) {
    http_response_code(400);
    echo json_encode(["error" => "Email y contraseña requeridos"]);
    exit;
}

try {
    $pdo = getDB();

    // Busca en usuario_cliente primero, luego en usuario_admin
    $tablas = ["usuario_cliente", "usuario_admin", "usuario_vendedor"];
    $usuario = null;
    $rol = null;

    foreach ($tablas as $tabla) {
        $stmt = $pdo->prepare("SELECT * FROM $tabla WHERE email = ?");
        $stmt->execute([$email]);
        $fila = $stmt->fetch(PDO::FETCH_ASSOC);
        
        //antiguamente tenia: ($fila && password_verify($password, $fila["password"]))
        //Eso era encriptación. No se usara en este proyecto
        if ($fila && $password === $fila["password"]) {
            $usuario = $fila;
            $rol = $tabla; // "usuario_cliente" | "usuario_admin" | "usuario_vendedor"
            break;
        }
    }

    if (!$usuario) {
        http_response_code(401);
        echo json_encode(["error" => "Credenciales incorrectas"]);
        exit;
    }

    // No devolvemos el password
    unset($usuario["password"]);
    $usuario["rol"] = $rol;

    echo json_encode(["ok" => true, "usuario" => $usuario]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

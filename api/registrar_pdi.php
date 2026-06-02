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

$body      = json_decode(file_get_contents("php://input"), true);
$nombre    = trim($body["nombre"]      ?? "");
$categoria = trim($body["categoria"]   ?? "");
$desc      = trim($body["descripcion"] ?? "");
$direccion = trim($body["direccion"]   ?? "");
$latitud   = $body["latitud"]          ?? null;
$longitud  = $body["longitud"]         ?? null;
$foto      = trim($body["foto"]        ?? "");
$id_vend   = !empty($body["id_vendedor"]) ? (int) $body["id_vendedor"] : null;
$id_admin  = (int) ($body["id_admin"]  ?? 0);

// ── Validaciones ─────────────────────────────────────────────────────────────
if (!$nombre || !$categoria || $latitud === null || $longitud === null || !$id_admin) {
    http_response_code(400);
    echo json_encode(["error" => "Nombre, categoría, latitud, longitud e id_admin son obligatorios"]);
    exit;
}

if ($latitud < -90 || $latitud > 90) {
    http_response_code(400);
    echo json_encode(["error" => "Latitud fuera de rango (-90 a 90)"]);
    exit;
}

if ($longitud < -180 || $longitud > 180) {
    http_response_code(400);
    echo json_encode(["error" => "Longitud fuera de rango (-180 a 180)"]);
    exit;
}

try {
    $pdo = getDB();

    // Verificar que el admin existe
    $chk = $pdo->prepare("SELECT id_admin FROM usuario_admin WHERE id_admin = ?");
    $chk->execute([$id_admin]);
    if (!$chk->fetch()) {
        http_response_code(403);
        echo json_encode(["error" => "ID de administrador inválido"]);
        exit;
    }

    $stmt = $pdo->prepare("
        INSERT INTO pdi (nombre, categoria, descripcion, direccion, latitud, longitud, foto, id_vendedor, id_admin)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([$nombre, $categoria, $desc, $direccion, $latitud, $longitud, $foto, $id_vend, $id_admin]);

    echo json_encode([
        "ok"     => true,
        "mensaje"=> "Punto registrado exitosamente",
        "id_pdi" => (int) $pdo->lastInsertId()
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

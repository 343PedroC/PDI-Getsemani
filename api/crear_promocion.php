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

$body        = json_decode(file_get_contents("php://input"), true);
$nombre      = trim($body["nombre"]       ?? "");
$informacion = trim($body["informacion"]  ?? "");
$fecha_inicio = trim($body["fecha_inicio"] ?? "");
$fecha_fin    = trim($body["fecha_fin"]    ?? "");
$id_pdi       = (int) ($body["id_pdi"]      ?? 0);
$id_vendedor  = (int) ($body["id_vendedor"] ?? 0);

// ── Validaciones ─────────────────────────────────────────────────────────────
if (!$nombre || !$fecha_inicio || !$fecha_fin || !$id_pdi || !$id_vendedor) {
    http_response_code(400);
    echo json_encode(["error" => "Nombre, fechas e ID del punto son obligatorios"]);
    exit;
}

if (strlen($nombre) > 100) {
    http_response_code(400);
    echo json_encode(["error" => "El nombre no puede superar 100 caracteres"]);
    exit;
}

if (strlen($informacion) > 500) {
    http_response_code(400);
    echo json_encode(["error" => "La descripción no puede superar 500 caracteres"]);
    exit;
}

if (strtotime($fecha_fin) <= strtotime($fecha_inicio)) {
    http_response_code(400);
    echo json_encode(["error" => "La fecha de fin debe ser posterior a la de inicio"]);
    exit;
}

try {
    $pdo = getDB();

    // Verificar que el PDI realmente pertenece a este vendedor (seguridad)
    $chk = $pdo->prepare("SELECT id_pdi FROM pdi WHERE id_pdi = ? AND id_vendedor = ?");
    $chk->execute([$id_pdi, $id_vendedor]);
    if (!$chk->fetch()) {
        http_response_code(403);
        echo json_encode(["error" => "Este punto no pertenece a tu cuenta"]);
        exit;
    }

    // Insertar la nueva promoción
    $stmt = $pdo->prepare("
        INSERT INTO promocion_punto (nombre, informacion, fecha_inicio, fecha_fin, id_vendedor, id_pdi)
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([$nombre, $informacion, $fecha_inicio, $fecha_fin, $id_vendedor, $id_pdi]);

    echo json_encode([
        "ok"           => true,
        "mensaje"      => "Promoción publicada exitosamente",
        "id_promocion" => (int) $pdo->lastInsertId(),
        "id_pdi"       => $id_pdi
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

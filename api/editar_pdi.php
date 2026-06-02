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
$id_pdi    = (int)   ($body["id_pdi"]      ?? 0);
$nombre    = trim($body["nombre"]           ?? "");
$categoria = trim($body["categoria"]        ?? "");
$desc      = trim($body["descripcion"]      ?? "");
$direccion = trim($body["direccion"]        ?? "");
$latitud   = $body["latitud"]               ?? null;
$longitud  = $body["longitud"]              ?? null;
$foto      = trim($body["foto"]             ?? "");
$id_vend   = !empty($body["id_vendedor"]) ? (int) $body["id_vendedor"] : null;
$id_admin  = (int) ($body["id_admin"]       ?? 0);

// ── Validaciones ─────────────────────────────────────────────────────────────
if (!$id_pdi || !$nombre || !$categoria || $latitud === null || $longitud === null || !$id_admin) {
    http_response_code(400);
    echo json_encode(["error" => "ID del punto, nombre, categoría, latitud, longitud e id_admin son obligatorios"]);
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

    // Verificar que el punto existe
    $chk = $pdo->prepare("SELECT id_pdi FROM pdi WHERE id_pdi = ?");
    $chk->execute([$id_pdi]);
    if (!$chk->fetch()) {
        http_response_code(404);
        echo json_encode(["error" => "No se encontró ningún punto con ese ID"]);
        exit;
    }

    $stmt = $pdo->prepare("
        UPDATE pdi
        SET nombre      = ?,
            categoria   = ?,
            descripcion = ?,
            direccion   = ?,
            latitud     = ?,
            longitud    = ?,
            foto        = ?,
            id_vendedor = ?,
            id_admin    = ?
        WHERE id_pdi = ?
    ");
    $stmt->execute([$nombre, $categoria, $desc, $direccion, $latitud, $longitud, $foto, $id_vend, $id_admin, $id_pdi]);

    echo json_encode([
        "ok"      => true,
        "mensaje" => "Punto actualizado exitosamente",
        "id_pdi"  => $id_pdi
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

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
$id_pdi   = (int) ($body["id_pdi"]   ?? 0);
$id_admin = (int) ($body["id_admin"] ?? 0);

if (!$id_pdi || !$id_admin) {
    http_response_code(400);
    echo json_encode(["error" => "id_pdi e id_admin son obligatorios"]);
    exit;
}

try {
    $pdo = getDB();

    // Verificar que el punto existe antes de intentar borrar
    $chk = $pdo->prepare("SELECT id_pdi FROM pdi WHERE id_pdi = ?");
    $chk->execute([$id_pdi]);
    if (!$chk->fetch()) {
        http_response_code(404);
        echo json_encode(["error" => "No se encontró ningún punto con ese ID"]);
        exit;
    }

    // Eliminar en transacción: primero registros dependientes, luego el PDI
    $pdo->beginTransaction();

    // 1. Opiniones y calificaciones
    $pdo->prepare("DELETE FROM opiniones_y_calificaciones WHERE id_pdi = ?")
        ->execute([$id_pdi]);

    // 2. Promociones del punto
    $pdo->prepare("DELETE FROM promocion_punto WHERE id_pdi = ?")
        ->execute([$id_pdi]);

    // 3. El punto en sí
    $pdo->prepare("DELETE FROM pdi WHERE id_pdi = ?")
        ->execute([$id_pdi]);

    $pdo->commit();

    echo json_encode([
        "ok"      => true,
        "mensaje" => "Punto eliminado correctamente junto con sus reseñas y promociones"
    ]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

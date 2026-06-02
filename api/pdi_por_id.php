<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");

require_once "db.php";

if ($_SERVER["REQUEST_METHOD"] !== "GET") {
    http_response_code(405);
    echo json_encode(["error" => "Método no permitido"]);
    exit;
}

$id_pdi = $_GET["id_pdi"] ?? null;

if (!$id_pdi) {
    http_response_code(400);
    echo json_encode(["error" => "id_pdi requerido"]);
    exit;
}

try {
    $pdo  = getDB();
    $stmt = $pdo->prepare("SELECT * FROM pdi WHERE id_pdi = ?");
    $stmt->execute([$id_pdi]);
    $pdi = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$pdi) {
        http_response_code(404);
        echo json_encode(["error" => "No se encontró ningún punto con ese ID"]);
        exit;
    }

    $pdi["id_pdi"]   = (int)   $pdi["id_pdi"];
    $pdi["latitud"]  = (float) $pdi["latitud"];
    $pdi["longitud"] = (float) $pdi["longitud"];

    echo json_encode($pdi);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

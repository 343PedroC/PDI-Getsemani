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

$id_vendedor = $_GET["id_vendedor"] ?? null;

if (!$id_vendedor) {
    http_response_code(400);
    echo json_encode(["error" => "id_vendedor requerido"]);
    exit;
}

try {
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT id_pdi, nombre, categoria, direccion
        FROM pdi
        WHERE id_vendedor = ?
        ORDER BY nombre ASC
    ");
    $stmt->execute([$id_vendedor]);
    $pois = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($pois as &$p) {
        $p["id_pdi"] = (int) $p["id_pdi"];
    }

    echo json_encode($pois);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

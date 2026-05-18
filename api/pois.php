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

try {
    $pdo = getDB();

    $categoria = $_GET["categoria"] ?? null;

    if ($categoria && $categoria !== "Todos") {
        $stmt = $pdo->prepare("SELECT * FROM pdi WHERE categoria = ? ORDER BY nombre");
        $stmt->execute([$categoria]);
    } else {
        $stmt = $pdo->query("SELECT * FROM pdi ORDER BY nombre");
    }

    $pois = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Convertir latitud y longitud a float para que JS los reciba bien
    foreach ($pois as &$p) {
        $p["latitud"]  = (float) $p["latitud"];
        $p["longitud"] = (float) $p["longitud"];
    }

    echo json_encode($pois);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

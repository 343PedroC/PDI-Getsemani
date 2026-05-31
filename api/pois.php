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
    
    /*
    if ($categoria && $categoria !== "Todos") {
        $stmt = $pdo->prepare("SELECT * FROM pdi WHERE categoria = ? ORDER BY nombre");
        $stmt->execute([$categoria]);
    } else {
        $stmt = $pdo->query("SELECT * FROM pdi ORDER BY nombre");
    }
    */

    // Subquery para detectar si el PDI tiene una promoción activa en este momento
    $subquery = "CASE WHEN EXISTS (
                    SELECT 1 FROM promocion_punto pp
                    WHERE pp.id_pdi = p.id_pdi
                      AND NOW() BETWEEN pp.fecha_inicio AND pp.fecha_fin
                 ) THEN 1 ELSE 0 END AS tiene_promo";
 
    if ($categoria && $categoria !== "Todos") {
        $stmt = $pdo->prepare("
            SELECT p.*, {$subquery}
            FROM pdi p
            WHERE p.categoria = ?
            ORDER BY p.nombre
        ");
        $stmt->execute([$categoria]);
    } else {
        $stmt = $pdo->query("
            SELECT p.*, {$subquery}
            FROM pdi p
            ORDER BY p.nombre
        ");
    }

    $pois = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Convertir latitud y longitud a float para que JS los reciba bien
    foreach ($pois as &$p) {
        $p["latitud"]  = (float) $p["latitud"];
        $p["longitud"] = (float) $p["longitud"];
        $p["tiene_promo"] = (bool)  $p["tiene_promo"];
    }

    echo json_encode($pois);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>

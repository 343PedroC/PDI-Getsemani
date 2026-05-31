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

$id_pdi = $_GET["id_pdi"] ?? null; //NOT NULL ????? ARREGLAR ESTO

if (!$id_pdi) {
    http_response_code(400);
    echo json_encode(["error" => "id_pdi requerido"]);
    exit;
}

try {
    $pdo = getDB();

    // Traemos la promo activa más reciente junto con el nombre del PDI
    $stmt = $pdo->prepare("
        SELECT
            pp.id_promocion,
            pp.nombre,
            pp.informacion,
            pp.fecha_inicio,
            pp.fecha_fin,
            p.id_pdi,
            p.nombre     AS nombre_pdi,
            p.categoria,
            p.direccion
        FROM promocion_punto pp
        JOIN pdi p ON pp.id_pdi = p.id_pdi
        WHERE pp.id_pdi = ?
          AND NOW() BETWEEN pp.fecha_inicio AND pp.fecha_fin
        ORDER BY pp.fecha_inicio DESC
        LIMIT 1
    ");
    $stmt->execute([$id_pdi]);
    $promo = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$promo) {
        http_response_code(404);
        echo json_encode(["error" => "No hay promociones activas para este punto"]);
        exit;
    }

    echo json_encode($promo);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>
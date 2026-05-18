<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once "db.php";

$method = $_SERVER["REQUEST_METHOD"];

// ── GET: obtener reseñas de un PDI ───────────────────────────────────────────
if ($method === "GET") {
    $id_pdi = $_GET["id_pdi"] ?? null;

    if (!$id_pdi) {
        http_response_code(400);
        echo json_encode(["error" => "id_pdi requerido"]);
        exit;
    }

    try {
        $pdo = getDB();

        // Traemos las reseñas con el nombre del cliente
        $stmt = $pdo->prepare("
            SELECT 
                o.id_opinion,
                o.puntuacion,
                o.comentario,
                o.fecha,
                c.nombre AS usuario
            FROM opiniones_y_calificaciones o
            JOIN usuario_cliente c ON o.id_cliente = c.id_cliente
            WHERE o.id_pdi = ?
            ORDER BY o.fecha DESC
        ");
        $stmt->execute([$id_pdi]);
        $resenas = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Calcular promedio
        $promedio = 0;
        if (count($resenas) > 0) {
            $suma = array_sum(array_column($resenas, "puntuacion"));
            $promedio = round($suma / count($resenas), 1);
        }

        echo json_encode([
            "resenas"  => $resenas,
            "promedio" => $promedio,
            "total"    => count($resenas)
        ]);

    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    }
    exit;
}

// ── POST: guardar una nueva reseña ────────────────────────────────────────────
if ($method === "POST") {
    $body       = json_decode(file_get_contents("php://input"), true);
    $id_pdi     = $body["id_pdi"]     ?? null;
    $id_cliente = $body["id_cliente"] ?? null;
    $puntuacion = $body["puntuacion"] ?? null;
    $comentario = trim($body["comentario"] ?? "");

    if (!$id_pdi || !$id_cliente || !$puntuacion) {
        http_response_code(400);
        echo json_encode(["error" => "id_pdi, id_cliente y puntuacion son requeridos"]);
        exit;
    }

    if ($puntuacion < 1 || $puntuacion > 5) {
        http_response_code(400);
        echo json_encode(["error" => "Puntuación debe ser entre 1 y 5"]);
        exit;
    }

    try {
        $pdo = getDB();

        $stmt = $pdo->prepare("
            INSERT INTO opiniones_y_calificaciones (puntuacion, comentario, id_cliente, id_pdi)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$puntuacion, $comentario, $id_cliente, $id_pdi]);

        echo json_encode(["ok" => true, "mensaje" => "Reseña guardada"]);

    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    }
    exit;
}

http_response_code(405);
echo json_encode(["error" => "Método no permitido"]);
?>

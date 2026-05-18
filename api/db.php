<?php
function getDB() {
    $pdo = new PDO(
        "mysql:host=localhost;dbname=getsemani;charset=utf8",
        "root",
        "",
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    return $pdo;
}
?>

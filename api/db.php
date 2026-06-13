<?php
// ── Credenciales de base de datos ─────────────────────────────────────────────
//
// DESARROLLO LOCAL (XAMPP):
//   Las constantes de abajo se toman directamente.
//
// HOSTING (InfinityFree u otro):
//   Reemplaza los valores con los que te da el panel de control del hosting.
//   DB_HOST  → host MySQL del hosting  (ej. "sql123.infinityfree.com")
//   DB_NAME  → nombre de la base de datos creada en el hosting
//   DB_USER  → usuario MySQL del hosting
//   DB_PASS  → contraseña MySQL del hosting
//
define('DB_HOST', 'sql305.infinityfree.com');
define('DB_NAME', 'if0_42101837_getsemani');
define('DB_USER', 'if0_42101837');
define('DB_PASS', '3BZpV0bRysbyDV0');

function getDB() {
    static $pdo = null;
    if ($pdo === null) {
        $pdo = new PDO(
            "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8",
            DB_USER,
            DB_PASS,
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
        );
    }
    return $pdo;
}
?>

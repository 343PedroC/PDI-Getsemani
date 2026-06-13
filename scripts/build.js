/**
 * Copia los archivos del frontend a la carpeta www/
 * para que Capacitor los empaquete en el APK.
 *
 * NO se copian: api/, DB MySQL/, android/, node_modules/, scripts/
 * Ejecutar con: npm run build
 */

const fs   = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const WWW  = path.join(ROOT, 'www');

// Archivos individuales a copiar
const FILES = ['index.html', 'mapa.html', 'estilos.css'];

// Carpetas completas a copiar
const DIRS = ['js', 'html', 'Fotos', 'data'];

// ── Utilidad: copia recursiva de carpeta ─────────────────────────────────────
function copyDir(src, dst) {
    if (!fs.existsSync(dst)) fs.mkdirSync(dst, { recursive: true });
    for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
        const s = path.join(src, entry.name);
        const d = path.join(dst, entry.name);
        entry.isDirectory() ? copyDir(s, d) : fs.copyFileSync(s, d);
    }
}

// ── Exportar datos a JSON (APK offline) ──────────────────────────────────────
const { execSync } = require('child_process');
try {
    execSync('node scripts/export-data.js', { cwd: ROOT, stdio: 'inherit' });
} catch (e) {
    console.warn('  export-data: se usa data/store.json existente');
}

// ── Copiar archivos ───────────────────────────────────────────────────────────
for (const file of FILES) {
    const src = path.join(ROOT, file);
    if (fs.existsSync(src)) {
        fs.copyFileSync(src, path.join(WWW, file));
        console.log(`  copiado: ${file}`);
    } else {
        console.warn(`  no encontrado (se omite): ${file}`);
    }
}

// ── Copiar carpetas ───────────────────────────────────────────────────────────
for (const dir of DIRS) {
    const src = path.join(ROOT, dir);
    if (fs.existsSync(src)) {
        copyDir(src, path.join(WWW, dir));
        console.log(`  copiada carpeta: ${dir}/`);
    } else {
        console.warn(`  carpeta no encontrada (se omite): ${dir}/`);
    }
}

console.log('\nBuild completado. Archivos listos en www/');

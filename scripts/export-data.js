/**
 * Exporta datos de getsemani_export.sql a data/store.json para la APK offline.
 * Ejecutar: node scripts/export-data.js
 */

const fs = require('fs');
const path = require('path');

const SQL_FILE = path.join(__dirname, '..', 'DB MySQL', 'getsemani_export.sql');
const OUT_DIR  = path.join(__dirname, '..', 'data');
const OUT_FILE = path.join(OUT_DIR, 'store.json');

const SCHEMAS = {
    pdi: ['id_pdi', 'nombre', 'categoria', 'descripcion', 'direccion', 'latitud', 'longitud', 'foto', 'id_vendedor', 'id_admin'],
    opiniones_y_calificaciones: ['id_opinion', 'puntuacion', 'comentario', 'fecha', 'id_cliente', 'id_pdi'],
    promocion_punto: ['id_promocion', 'nombre', 'informacion', 'fecha_inicio', 'fecha_fin', 'id_vendedor', 'id_pdi'],
    usuario_admin: ['id_admin', 'nombre', 'email', 'password', 'nivel_acceso', 'fecha_registro'],
    usuario_cliente: ['id_cliente', 'nombre', 'apellidos', 'email', 'password', 'fecha_registro', 'id_admin'],
    usuario_vendedor: ['id_vendedor', 'nombre', 'email', 'password', 'fecha_registro', 'id_admin'],
};

function parseValue(raw) {
    if (raw === 'NULL') return null;
    if (/^-?\d+(\.\d+)?$/.test(raw)) return Number(raw);
    return raw;
}

function parseInsertValues(str) {
    const rows = [];
    let i = 0;

    while (i < str.length) {
        if (str[i] !== '(') { i++; continue; }
        i++;
        const fields = [];
        let cur = '';
        let inStr = false;

        while (i < str.length) {
            const c = str[i];

            if (inStr) {
                if (c === "'") {
                    if (str[i + 1] === "'") { cur += "'"; i += 2; continue; }
                    inStr = false;
                    i++;
                    continue;
                }
                if (c === '\\') { cur += str[i + 1] || ''; i += 2; continue; }
                cur += c;
                i++;
                continue;
            }

            if (c === "'") { inStr = true; i++; continue; }

            if (c === ',') {
                fields.push(parseValue(cur.trim()));
                cur = '';
                i++;
                continue;
            }

            if (c === ')') {
                fields.push(parseValue(cur.trim()));
                rows.push(fields);
                i++;
                break;
            }

            cur += c;
            i++;
        }
    }

    return rows;
}

function rowsToObjects(table, rows) {
    const cols = SCHEMAS[table];
    return rows.map(row => {
        const obj = {};
        cols.forEach((col, idx) => { obj[col] = row[idx]; });
        return obj;
    });
}

function extractInserts(sql, table) {
    const re = new RegExp(`INSERT INTO \`${table}\` VALUES ([^;]+);`, 's');
    const m = sql.match(re);
    if (!m) return [];
    return rowsToObjects(table, parseInsertValues(m[1]));
}

const sql = fs.readFileSync(SQL_FILE, 'utf8');
const store = {};

for (const table of Object.keys(SCHEMAS)) {
    store[table] = extractInserts(sql, table);
    console.log(`  ${table}: ${store[table].length} registros`);
}

if (!fs.existsSync(OUT_DIR)) fs.mkdirSync(OUT_DIR, { recursive: true });
fs.writeFileSync(OUT_FILE, JSON.stringify(store, null, 0));
console.log(`\nExportado: ${OUT_FILE} (${(fs.statSync(OUT_FILE).size / 1024).toFixed(1)} KB)`);

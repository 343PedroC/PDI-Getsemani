// ── CONFIGURACIÓN CENTRAL DE API ─────────────────────────────────────────────
//
// Navegador (XAMPP)  → API PHP local en /PDI_Getsemani/api
// APK (Capacitor)    → API empaquetada en data/store.json (sin internet)
//
const _isNative = !!(
    window.Capacitor &&
    window.Capacitor.isNativePlatform &&
    window.Capacitor.isNativePlatform()
);

const USE_LOCAL_API = _isNative;
window.USE_LOCAL_API = USE_LOCAL_API;

const API_LOCAL = '/PDI_Getsemani/api';
const API_OFFLINE = 'local://api'; // placeholder; local-api.js intercepta fetch

const API_URL = USE_LOCAL_API ? API_OFFLINE : API_LOCAL;

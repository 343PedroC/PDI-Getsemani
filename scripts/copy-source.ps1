# Excluidos en cualquier nivel del árbol
$globalExclude = @('node_modules', '.git', 'hosting_upload.zip', 'copy-source.ps1', 'make-zip.ps1', 'check-sizes.ps1')

# Rutas relativas a excluir completamente (carpetas generables con npm run sync)
$deepExclude = @(
    'android\app\build',
    'android\build',
    'android\.gradle',
    'android\app\src\main\assets',  # generado por cap sync (contiene copia de www/)
    'www'                            # generado por npm run build
)

$srcRoot = 'C:\xampp\htdocs\PDI_Getsemani'
$dstRoot = 'C:\Users\pedri\Desktop\Puntos_Pedro_David\PDI_Getsemani'

function ShouldExclude($rel) {
    foreach ($ex in $deepExclude) {
        if ($rel -eq $ex -or $rel.StartsWith("$ex\")) { return $true }
    }
    return $false
}

function CopyClean($from, $to, $rel) {
    if (!(Test-Path $to)) { New-Item -ItemType Directory -Force -Path $to | Out-Null }
    Get-ChildItem -Path $from | ForEach-Object {
        $itemRel = if ($rel) { "$rel\$($_.Name)" } else { $_.Name }
        if ($globalExclude -contains $_.Name) { return }
        if (ShouldExclude $itemRel) { return }
        $target = Join-Path $to $_.Name
        if ($_.PSIsContainer) {
            CopyClean $_.FullName $target $itemRel
        } else {
            Copy-Item $_.FullName $target -Force
        }
    }
}

New-Item -ItemType Directory -Force -Path $dstRoot | Out-Null
New-Item -ItemType Directory -Force -Path 'C:\Users\pedri\Desktop\Puntos_Pedro_David\distribuible' | Out-Null
New-Item -ItemType Directory -Force -Path 'C:\Users\pedri\Desktop\Puntos_Pedro_David\docs' | Out-Null

CopyClean $srcRoot $dstRoot ''
Write-Host "Copia fuente completada"

Copy-Item 'C:\xampp\htdocs\PDI_Getsemani\android\app\build\intermediates\apk\debug\app-debug.apk' `
          'C:\Users\pedri\Desktop\Puntos_Pedro_David\distribuible\PDI_Getsemani.apk' -Force
Write-Host "APK copiada"

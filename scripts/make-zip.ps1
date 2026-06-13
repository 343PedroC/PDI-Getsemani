$src  = 'C:\Users\pedri\Desktop\Puntos_Pedro_David'
$dest = 'C:\Users\pedri\Desktop\Puntos_Pedro_David.zip'

if (Test-Path $dest) { Remove-Item $dest -Force }
Compress-Archive -Path $src -DestinationPath $dest
Write-Host "ZIP creado: $dest"
$size = [math]::Round((Get-Item $dest).Length / 1MB, 1)
Write-Host "Tamaño: $size MB"

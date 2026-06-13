$base = 'C:\Users\pedri\Desktop\Puntos_Pedro_David\PDI_Getsemani'
Get-ChildItem $base | ForEach-Object {
    $item = $_
    if ($item.PSIsContainer) {
        $bytes = (Get-ChildItem $item.FullName -Recurse -File | Measure-Object Length -Sum).Sum
    } else {
        $bytes = $item.Length
    }
    $mb = [math]::Round($bytes / 1MB, 1)
    Write-Host "$mb MB  $($item.Name)"
} | Sort-Object

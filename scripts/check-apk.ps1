$apk = Get-Item 'C:\Users\pedri\Desktop\Puntos_Pedro_David\distribuible\PDI_Getsemani.apk'
$mb = [math]::Round($apk.Length / 1MB)
Write-Host "$($apk.Name): $mb MB"

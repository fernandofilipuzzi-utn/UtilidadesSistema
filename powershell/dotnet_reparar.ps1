
#https://support.microsoft.com/es-es/topic/la-herramienta-de-reparaci%C3%B3n-de-microsoft-net-framework-est%C3%A1-disponible-942a01e3-5b8b-7abb-c166-c34a2f4b612a
#https://aka.ms/DotnetRepairTool
#NetfxRepairTool.exe /addsource \\SHARE_PC\SHARE_FOLDER 

# URL de descarga
$downloadUrl = "https://aka.ms/DotnetRepairTool"
# Ruta de destino
$downloadPath = ".\NetfxRepairTool.exe"

# Descargando 
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

if (Test-Path $downloadPath) {
    Write-Host "Descarga exitosa , Ejecutando ..."
    Start-Process -FilePath $downloadPath -ArgumentList "/addsource \\SHARE_PC\SHARE_FOLDER" -Wait
    Write-Host "Ejecutado correctamente."
} else {
    Write-Host "Error en la descara"
}

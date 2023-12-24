# se requieren permisos de administrador

# verifica si hay corrupción en la imagen del sistema sin intentar repararla
DISM /Online /Cleanup-Image /CheckHealth

# análisis más profundo de la imagen del sistema para detectar cualquier corrupción
DISM /Online /Cleanup-Image /ScanHealth

# intenta corregir los problemas identificados durante el análisis
DISM /Online /Cleanup-Image /RestoreHealth

# comprueba el sistema de ficheros e intenta reparar
Invoke-Expression -Command "sfc /scannow"
#iex "sfc /scannow"
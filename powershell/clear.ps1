# Script para limpiar la PC

# Rutas a limpiar
$carpetas = @(
    [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop'),
    [System.IO.Path]::Combine($env:USERPROFILE, 'Documents'),
    [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads'),
    [System.IO.Path]::Combine($env:USERPROFILE, 'Pictures'),
    [System.IO.Path]::Combine($env:USERPROFILE, 'AppData\Local\Temp')  # Agregado para limpiar la carpeta Temp
    # Agrega otras carpetas según sea necesario
)

# Carpetas adicionales a excluir
$carpetasExcluir = @(
#    'AppData\Local\Temp',
#    'AppData\Local\Microsoft\Windows\INetCache',  
#    'AppData\Local\Microsoft\Windows\Explorer',
#    'AppData\Local\Microsoft\Windows\History',
#    'AppData\Local\Microsoft\Windows\Temporary Internet Files'
)

# Archivos a excluir
$archivosDelSistema = @(
    'desktop.ini',
    'thumbs.db'
    # Otros archivos del sistema
)

foreach ($carpeta in $carpetas) {
    # Verificar si la carpeta existe

    if (Test-Path $carpeta -PathType Container) {

        # Listar archivos de las carpetas
        $archivosABorrar = Get-ChildItem -Path $carpeta | Where-Object { $_.Name -notin $archivosDelSistema }

        # Eliminar archivos
        foreach ($archivo in $archivosABorrar) {           
            Remove-Item -Path $archivo.FullName -Force -Recurse -Confirm:$false
            Write-Host "Se ha eliminado: $($archivo.FullName)"
        }
    } else {
        Write-Host "La carpeta $carpeta no existe."
    }
}

foreach ($carpetaExcluir in $carpetasExcluir) {
    $rutaExcluir = [System.IO.Path]::Combine($env:USERPROFILE, $carpetaExcluir)

    # Verificar si la carpeta existe
    if (Test-Path $rutaExcluir -PathType Container) {
        # Eliminar el contenido de la carpeta
        Remove-Item -Path $rutaExcluir\* -Force -Recurse -Confirm:$false
        Write-Host "Se ha eliminado el contenido de: $rutaExcluir"
    } else {
        Write-Host "La carpeta $rutaExcluir no existe."
    }
}

Write-Host "Limpieza realizada!"

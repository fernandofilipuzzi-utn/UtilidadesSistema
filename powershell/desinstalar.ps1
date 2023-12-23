# Lista de nombres de aplicaciones a deshabilitar
$aplicacionesDeshabilitar = @(
    "El Tiempo",
    "Mapas",
    "IIS 10.0 Express",
    "Google Chrome",
    "Git",
    "Centro de opiniones",
    "Contactos",
    "Dev Home",
    "Microsoft Teams",
    "Microsoft To Do",
    "Solitaire & Casual Games",
    "Microsoft OneDrive",
    "Notas rápidas",
    "Noticias",
    "Asistencia rápida",
    "Visual Studio Community 2019",
     "Visual Studio Studio Installer",
     "Microsoft Visual C++",
    "Visual Web Deploy 4.0"
    # otros
)

foreach ($appNombre in $aplicacionesDeshabilitar) {
    Write-Host "Deshabilitando $appNombre..."

    # Deshabilitar la aplicación en el Registro
    try {
	#get-package $appNombre | uninstall-package  -Force  -Confirm:$false
        #get-package $appNombre |   %{ & $_.metadata['uninstallstring'] /S }

        $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
        $app = Get-ChildItem -Path $RegPath | Get-ItemProperty | Where-Object {$_.DisplayName -match $appNombre }
        $app.QuietUninstallString | cmd 

		$installedMsiObject = Get-WmiObject -Class Win32_Product | Where-Object { $_.PackageName -like $appName }
		if ($installedMsiObject) {
			try {
					$installedMsiObject.UnInstall() | Out-Null
				}
			catch {
				   Write-Error "Error occurred: $_"
			}
		}
    } catch {
        Write-Host ("Error al deshabilitar {0}: {1}" -f $appNombre, $_.Exception.Message)
    }
}

Write-Host "Proceso de deshabilitación completado."

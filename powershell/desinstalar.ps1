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
)

foreach ($appNombre in $aplicacionesDeshabilitar) {
    #$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall", "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    #$app = Get-ChildItem -Path $RegPath | Get-ItemProperty | Where-Object {$_.DisplayName -match $appNombre }
	
	$RegPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    )
	
	$app = $null
    foreach ($RegPath in $RegPaths) {
        $app = Get-ChildItem -Path $RegPath | Get-ItemProperty | Where-Object {$_.DisplayName -match $appNombre }
        if ($app) { break }
    }
				
	if($app)		
	{
		Write-Host ">> $app`n`n"
		Write-Host ">> $app.UninstallString`n`n"
		
		# Dividir la cadena usando la comilla doble como delimitador
		$elementos = $app.UninstallString -split '"'

		
		$path = $elementos[1]
		$argumentos = $elementos[2]

		
		Write-Host "Path: $path"
		Write-Host "Argumentos: $argumentos"
		
		Start-Process -FilePath $path -ArgumentList "$argumentos /S /Q" -NoNewWindow -PassThru | Wait-Process
		#Start-Process -FilePath $path -ArgumentList "$argumentos /S" -NoNewWindow -Wait
	}
	else
	{
		Write-Host "$appNombre no encontrado.`n`n"
	}
}
Write-Host "Proceso de deshabilitación completado."

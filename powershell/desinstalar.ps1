# Lista de nombres de aplicaciones a deshabilitar
$aplicacionesDeshabilitar = @(
    "Microsoft.BingWeather", #El Tiempo
    "Microsoft.WindowsMaps",
	"Microsoft.Wind234owsMaps",
	"Microsoft.549981C3F5F10", #cortana
	"Microsoft.StickyNotes", #notas rápidas
	"Microsoft.BingNews", #Noticias
	"Microsoft.XboxDevHome",  #Dev Home
	"Microsoft.People", #Centro de opiniones
	"Microsoft.WindowsFeedbackHub", #Contactos
	"Microsoft.Todos",#Microsoft To Do
	"Microsoft.SolitaireCollection",  #Solitaire & Casual Games
    "IIS 10.0 Express",
    "Microsoft Teams",        
    "Microsoft OneDrive",
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
		#Start-Process -FilePath $path -ArgumentList "$argumentos /S /Q" -NoNewWindow -Wait
	}
	else
	{
		Get-AppxPackage -Name $RegPath | Remove-AppxPackage
		
		#$app=$app.InstallLocation		
		
		
		
		if(-not $app)
		{
			Write-Host "$appNombre no encontrado.`n`n"
		}
	}
}
Write-Host "Proceso de deshabilitación completado."

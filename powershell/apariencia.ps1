# Configuración apariencia de Windows
# referencias: https://nosari20.github.io/posts/windows-default-theme/
$color = 0xfff4fe
$imgPath = ''  # Dejar vacío para desactivar la imagen de fondo
$temaClaro = 1  # 1 para tema claro, 0 para tema oscuro

#en cmd: start-process -filepath "C:\Windows\Resources\Themes\aero.theme"
#start-process -filepath "C:\Windows\Resources\Themes\aero.theme"
start-process -filepath "C:\Windows\Resources\Themes\aero.theme"; timeout /t 1; taskkill /im "systemsettings.exe" /f

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
	using Microsoft.Win32;
    public class Appearance {
        [DllImport("user32.dll")]
        public static extern bool SetSysColors(int cElements, int[] lpaElements, int[] lpaRgbValues);

        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);

        public static void SetColorBackground(int color) { 
            SetSysColors(1, new int[] { 1 }, new int[] { color });
        }

        public static void SetFileImgWallPapers(string imgPath) { 
            SystemParametersInfo(20, 0, imgPath, 3); 
        }
		
		public static void SetWindowsTheme(int theme) { 
            RegistryKey key = Registry.CurrentUser.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", true);
			key.SetValue("AppsUseLightTheme", 1);
			key.Close();

			RegistryKey key1 = Registry.CurrentUser.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", true);
            key1.SetValue("ColorPrevalence", 0);
			key1.Close();

            RegistryKey key2 = Registry.CurrentUser.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", true);
            key2.SetValue("EnableTransparency", false);
			key2.Close();

			RegistryKey key3 = Registry.CurrentUser.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", true);
            key3.SetValue("SystemUsesLightTheme", 1);
			key3.Close();

			RegistryKey key4 = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes", true);
			key4.SetValue("ThemeName", "C:\\Windows\\resources\\Themes\\aero.theme");
			key4.Close();		
                    
			RegistryKey key5 = Registry.LocalMachine.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes", true);
			key5.SetValue("CurrentTheme", "C:\\Windows\\resources\\Themes\\aero.theme");
			key5.Close();	
			
			RegistryKey key6 = Registry.LocalMachine.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Themes", true);
			key6.SetValue("ThemeMRU", "C:\\Windows\\resources\\Themes\\aero.theme;C:\\Windows\\resources\\Themes\\themeA.theme;C:\\Windows\\resources\\Themes\\themeC.theme;C:\\Windows\\resources\\Themes\\themeD.theme;C:\\Windows\\resources\\Themes\\themeB.theme;C:\\Windows\\resources\\Themes\\dark.theme;");
			key6.Close();			
        }
    }
"@

[Appearance]::SetColorBackground($color)
//[Appearance]::SetFileImgWallPapers($imgPath)
//[Appearance]::SetWindowsTheme($temaClaro)



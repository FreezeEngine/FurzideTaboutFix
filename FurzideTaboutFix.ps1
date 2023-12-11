# Путь к исходному файлу на GitHub
$sourceUrl = 'https://github.com/Aetopia/AppLifecycleOptOut/releases/download/v1.0.1/AppLifecycleOptOut.exe'
# Папка назначения
$destinationFolder = 'C:\MinecraftBE'
# Имя файла
$fileName = 'AppLifecycleOptOut.exe'
# Полный путь к целевому файлу
$destinationPath = Join-Path -Path $destinationFolder -ChildPath $fileName

# Загрузка файла с GitHub и сохранение в целевой папке
Invoke-WebRequest -Uri $sourceUrl -OutFile $destinationPath

# Проверка существования папки, и создание, если не существует
if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
    New-Item -Path $destinationFolder -ItemType Directory
}

# Создание задачи в планировщике
$action = New-ScheduledTaskAction -Execute "$destinationPath" -Argument 'Microsoft.MinecraftUWP_8wekyb3d8bbwe'
$trigger = New-ScheduledTaskTrigger -AtLogOn -User (Get-WMIObject -ClassName Win32_ComputerSystem).Username # setup trigger at logon
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName 'FurzideTaboutFix' -Description 'Furzide''s MinecraftBE Tabout Fix' -Settings $settings

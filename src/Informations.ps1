# Computername
$ComputerName = $env:COMPUTERNAME

# Datum und Uhrzeit
$Date = Get-Date

# Maximaler Arbeitsspeicher
$GetMaxRAM = (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory
$GetMaxRAMRounded = "~$([math]::Ceiling($GetMaxRAM / 1GB) ) GB"

# Maximaler Speicherplatz
$GetMaxStorage = (Get-Volume -DriveLetter C).Size
$GetMaxStorageRounded = "$([math]::Ceiling($GetMaxStorage / 1GB) ) GB"

# Verfügbarer Speicherplatz auf C:\
$GetAvailableStorageSpace = Get-PSDrive -Name 'C' | Select-Object -ExpandProperty Free
$GetAvailableStorageSpaceRounded = "~$([math]::Ceiling($GetAvailableStorageSpace / 1GB) ) GB"

# Anzahl der Prozessoren
$GetNumberOfProcessors = (Get-WmiObject Win32_ComputerSystem).NumberOfProcessors

# Windows-Version
$GetWindowsVersion = (Get-WmiObject Win32_OperatingSystem).Caption

# Informationen
$Informations = "Installierte Windows-Version: $GetWindowsVersion`n`n
Ihr Computername: $ComputerName`n`n
Datum und Uhrzeit: $Date`n`n
Maximaler Arbeitsspeicher: $GetMaxRAMRounded`n`n
Festplattenspeicher auf C:\: $GetAvailableStorageSpaceRounded/$GetMaxStorageRounded verwendet`n`n
Anzahl der Prozessoren: $GetNumberOfProcessors
"

$Informations > D:\Informationen.txt

Write-Host "`nFolgende Informationen wurden in D:\ gespeichert:`n`n$Informations"
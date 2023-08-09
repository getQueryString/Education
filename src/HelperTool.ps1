Write-Host "Startet ..."

##### UI einstellen
$ObjForm = New-Object System.Windows.Forms.Form
$ObjForm.Size = New-Object System.Drawing.Size(720, 480)
$ObjForm.FormBorderStyle = "FixedSingle"
$ObjForm.MaximizeBox = $false
# $ObjForm.TopMost = $true
$ObjForm.Text = "HelperTool by Fin"
$ObjForm.BackColor = "white"
$ObjForm.StartPosition = "CenterScreen"


##### Variablen
$ObjLabelWaitStandardText = "Click a button"
$NA = "Diese Funktion darf nicht ausgeführt werden oder ist zurzeit nicht verfügbar"



##### MenuBar
$ObjMenuStrip = New-Object System.Windows.Forms.MenuStrip
$ObjFileMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjFileMenu.Text = "Datei"

$ObjMenuItemSourceCode = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemSourceCode.Text = "Source Code"
$ObjMenuItemSourceCode.Add_Click({
    Start-Process "https://github.com/getQueryString/Education"
})

$Seperator = New-Object System.Windows.Forms.ToolStripSeparator

$ObjMenuItemExit = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemExit.Text = "Exit"
$ObjMenuItemExit.Add_Click({
    $ObjForm.Close()
})
$ObjFileMenu.DropDownItems.Add($ObjMenuItemSourceCode) > $null
$ObjFileMenu.DropDownItems.Add($Seperator) > $null
$ObjFileMenu.DropDownItems.Add($ObjMenuItemExit) > $null
$ObjMenuStrip.Items.Add($ObjFileMenu) > $null
$ObjForm.Controls.Add($ObjMenuStrip) > $null


#### Status label
$ObjLabelStatus = New-Object System.Windows.Forms.Label
$ObjLabelStatus.Size = New-Object System.Drawing.Size(600, 20)
$ObjLabelStatus.Location = New-Object System.Drawing.Size(20, 410)
$ObjLabelStatus.Text = $ObjLabelWaitStandardText
$ObjLabelStatus.Font = New-Object System.Drawing.Font("San Francisco", 11)
$ObjForm.Controls.Add($ObjLabelStatus)


#### Show PC informations
$Username = $env:USERNAME
$ComputerName = $env:COMPUTERNAME
$LogonServer = $env:LOGONSERVER
$UserDomain = $env:USERDOMAIN
$IPv4Address = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }).IPv4Address.IPAddress

$DefaultGatewayObject = Get-WmiObject Win32_ComputerSystem
$DefaultGatewayArray = $DefaultGatewayObject.DefaultIPGateway
if ($null -ne $DefaultGatewayArray -and $DefaultGatewayArray.Length -gt 0) {
    $DefaultGateway = $DefaultGatewayArray[0]
}
else {
    $DefaultGateway = "Nicht verfügbar"
}
$Date = Get-Date
$GetMaxRAM = (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory
$GetMaxRAMRounded = "~$([math]::Ceiling($GetMaxRAM / 1GB) ) GB"
$GetMaxStorage = (Get-Volume -DriveLetter C).Size
$GetMaxStorageRounded = "$([math]::Ceiling($GetMaxStorage / 1GB) ) GB"
$GetAvailableStorageSpace = Get-PSDrive -Name 'C' | Select-Object -ExpandProperty Free
$GetAvailableStorageSpaceRounded = "~$([math]::Ceiling($GetAvailableStorageSpace / 1GB) ) GB"
$GetNumberOfProcessors = (Get-WmiObject Win32_ComputerSystem).NumberOfProcessors
$GetWindowsVersion = (Get-WmiObject Win32_OperatingSystem).Caption

$PCInformations = "Installierte Windows-Version: `t$GetWindowsVersion`n`n
Username: `t`t`t$Username`n`n
Computername: `t`t`t$ComputerName`n`n
Angemeldet auf: `t`t$LogonServer`n`n
Userdomain: `t`t`t$UserDomain`n`n
IPv4-Adresse: `t`t`t$IPv4Address`n`n
Standardgateway: `t`t$DefaultGateway`n`n
Datum und Uhrzeit: `t`t$Date`n`n
Maximaler Arbeitsspeicher: `t$GetMaxRAMRounded`n`n
Festplattenspeicher auf C:\: `t$GetAvailableStorageSpaceRounded/$GetMaxStorageRounded verwendet`n`n
Anzahl der Prozessoren: `t$GetNumberOfProcessors
"
# Button
$ObjButtonPCInformations = New-Object System.Windows.Forms.Button
$ObjButtonPCInformations.Location = New-Object System.Drawing.Size(20, 40)
$ObjButtonPCInformations.Text = "PC informations"
$ObjButtonPCInformations.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonPCInformations.AutoSize = $true
$ObjButtonPCInformations.Add_Click({
    $ObjLabelStatus.Text = "Open text file ..."
    Open-File $PCInformations
})
$ObjForm.Controls.Add($ObjButtonPCInformations)


##### List Printers Button
$ObjButtonListPrinter = New-Object System.Windows.Forms.Button
$ObjButtonListPrinter.Location = New-Object System.Drawing.Size(135, 40)
$ObjButtonListPrinter.Text = "List Printers"
$ObjButtonListPrinter.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonListPrinter.AutoSize = $true
$ObjButtonListPrinter.Add_Click({
    $ObjLabelStatus.Text = "Open txt file ..."
    $Printers = Get-WMIObject -Class Win32_Printer -ComputerName $( hostname )
    $FormattedPrinters = $Printers | Format-Table -AutoSize -Wrap -HideTableHeaders | Out-String
    Open-File $FormattedPrinters
})
$ObjForm.Controls.Add($ObjButtonListPrinter)


##### Sysprep Button
$ObjButtonSysprep = New-Object System.Windows.Forms.Button
$ObjButtonSysprep.Location = New-Object System.Drawing.Size(230, 40)
$ObjButtonSysprep.Text = "Sysprep"
$ObjButtonSysprep.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonSysprep.AutoSize = $true
$ObjButtonSysprep.Add_Click({
    Write-Host $NA -ForegroundColor Red
    [System.Windows.Forms.MessageBox]::Show("Diese Funktion darf nicht ausgeführt werden oder ist zurzeit nicht verfügbar.",
            "Warnung", [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning)
})
$ObjForm.Controls.Add($ObjButtonSysprep)



##### WinGet Button
$ObjButtonWinGet = New-Object System.Windows.Forms.Button
$ObjButtonWinGet.Location = New-Object System.Drawing.Size(320, 40)
$ObjButtonWinGet.Text = "WinGet"
$ObjButtonWinGet.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonWinGet.AutoSize = $true
$ObjButtonWinGet.Add_Click({
    $WinGet = winget list
    Open-File $WinGet
})
$ObjForm.Controls.Add($ObjButtonWinGet)


##### WinGet Button
$ObjButtonWinGet = New-Object System.Windows.Forms.Button
$ObjButtonWinGet.Location = New-Object System.Drawing.Size(410, 40)
$ObjButtonWinGet.Text = "Processes"
$ObjButtonWinGet.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonWinGet.AutoSize = $true
$ObjButtonWinGet.Add_Click({
    $Process = Get-Process | Format-Table -Property Id, @{ Label = "CPU(s)"; Expression = { $_.CPU.ToString("N") + "%" }; Alignment = "Right" }, ProcessName -AutoSize
    Open-File $Process
})
$ObjForm.Controls.Add($ObjButtonWinGet)





##### Weather Button
$ObjButtonWeather = New-Object System.Windows.Forms.Button
$ObjButtonWeather.Location = New-Object System.Drawing.Size(500, 40)
$ObjButtonWeather.Text = "Weather"
$ObjButtonWeather.Font = New-Object System.Drawing.Font("San Francisco", 9)
$ObjButtonWeather.AutoSize = $true
$ObjButtonWeather.Add_Click({
    # $Process = (Invoke-WebRequest http://wttr.in/ -userAgent "curl" -useBasicParsing).Content
    # Open-File $Process
    Start-Process "https://wttr.in/"
})
$ObjForm.Controls.Add($ObjButtonWeather)


##### Open text file
function Open-File($Text) {
    $TempFileName = [System.IO.Path]::GetTempFileName()
    $TempFilePathWithoutExtension = [System.IO.Path]::ChangeExtension($TempFileName, "txt")
    $Text | Out-File -FilePath $TempFilePathWithoutExtension

    Start-Process -FilePath "notepad.exe" -ArgumentList $TempFilePathWithoutExtension

    $NotepadProcess = Get-Process | Where-Object { $_.ProcessName -eq "notepad" }
    if ($NotepadProcess) {
        $ObjLabelStatus.Text = "Close the file to continue using the program"
        $NotepadProcess.WaitForExit()
    }

    Remove-Item -Path $TempFilePathWithoutExtension
    Remove-Item -Path $TempFileName
    $ObjLabelStatus.Text = $ObjLabelWaitStandardText
}


##### Close UI dialog
<#$ObjForm.Add_FormClosing({
    $Response = [System.Windows.Forms.MessageBox]::Show("Möchten Sie HelperTool wirklich beenden?", "HelperTool beenden", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($Response -eq "No") {
        $_.Cancel = $true
    }
})#>


##### Show UI
$ObjForm.ShowDialog()
Write-Host "Startet ..."

##### UI einstellen
$ObjForm = New-Object System.Windows.Forms.Form
$ObjForm.Size = New-Object System.Drawing.Size(720, 480)
$ObjForm.FormBorderStyle = "FixedSingle"
$ObjForm.MaximizeBox = $false
# $ObjForm.TopMost = $true
$ObjForm.Text = "HelperTool by Fin – v1.0"
$ObjForm.BackColor = "white"
$ObjForm.StartPosition = "CenterScreen"


##### Variablen
$ObjLabelWaitStandardText = "Click a button"
$NA = "Diese Funktion darf nicht ausgeführt werden oder ist zurzeit nicht verfügbar."
$StandardFont = New-Object System.Drawing.Font("San Francisco", 9)
$StandardCursor = "Hand"
$GetDialogInput1 = ""
$GetDialogInput2 = ""


##### MenuBar
$ObjMenuStrip = New-Object System.Windows.Forms.MenuStrip

# Datei
$ObjMenuItemFile = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemFile.Text = "Datei"
# Source Code
$ObjMenuItemSourceCode = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemSourceCode.Text = "Source Code"
$ObjMenuItemSourceCode.Add_Click({
    Start-Process "https://github.com/getQueryString/Education/blob/master/src/HelperTool.ps1"
})
# Seperator
$Seperator = New-Object System.Windows.Forms.ToolStripSeparator
# Exit
$ObjMenuItemExit = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemExit.Text = "Exit"
$ObjMenuItemExit.Add_Click({
    $ObjForm.Close()
})
$ObjMenuItemFile.DropDownItems.Add($ObjMenuItemSourceCode) > $null
$ObjMenuItemFile.DropDownItems.Add($Seperator) > $null
$ObjMenuItemFile.DropDownItems.Add($ObjMenuItemExit) > $null


# Hilfe
$ObjMenuItemHelp = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemHelp.Text = "Hilfe"
# About HelperTool
$ObjMenuItemAbout = New-Object System.Windows.Forms.ToolStripMenuItem
$ObjMenuItemAbout.Text = "Über HelperTool"
$ObjMenuItemAbout.Add_Click({
    # About Forms
    $ObjFormAbout = New-Object System.Windows.Forms.Form
    $ObjFormAbout.Size = New-Object System.Drawing.Size(480, 250)
    $ObjFormAbout.FormBorderStyle = "FixedSingle"
    $ObjFormAbout.MaximizeBox = $false
    $ObjFormAbout.Text = "Über HelperTool"
    $ObjFormAbout.BackColor = "white"
    $ObjFormAbout.StartPosition = "CenterScreen"

    # Version Label
    $ObjAboutLabelVersion = New-Object System.Windows.Forms.Label
    $ObjAboutLabelVersion.Size = New-Object System.Drawing.Size(100, 20)
    $ObjAboutLabelVersion.Location = New-Object System.Drawing.Size(10, 10)
    $ObjAboutLabelVersion.Font = $StandardFont
    $ObjAboutLabelVersion.Text = "Version: 1.0"
    $ObjFormAbout.Controls.Add($ObjAboutLabelVersion)

    # Developer Label
    $ObjAboutLabelDeveloper = New-Object System.Windows.Forms.Label
    $ObjAboutLabelDeveloper.Size = New-Object System.Drawing.Size(150, 20)
    $ObjAboutLabelDeveloper.Location = New-Object System.Drawing.Size(10, 30)
    $ObjAboutLabelDeveloper.Font = $StandardFont
    $ObjAboutLabelDeveloper.Text = "Entwickler: Fin"
    $ObjFormAbout.Controls.Add($ObjAboutLabelDeveloper)

    # License Label
    $ObjAboutLabelLicense = New-Object System.Windows.Forms.Label
    $ObjAboutLabelLicense.Size = New-Object System.Drawing.Size(480, 40)
    $ObjAboutLabelLicense.Location = New-Object System.Drawing.Size(10, 170)
    $ObjAboutLabelLicense.Font = $StandardFont
    $ObjAboutLabelLicense.Text = "Lizenz:`nDieses Programm darf nur unter Angabe des Autors für eigene Zwecke verwendet, verändert und verbreitet werden."
    $ObjFormAbout.Controls.Add($ObjAboutLabelLicense)


    <#$Grid = New-Object System.Windows.Controls.Grid
    $ObjFormAbout.Content = $Grid

    $Border = New-Object System.Windows.Controls.Border
    $Border.BorderBrush = [System.Windows.Media.Brushes]::Black
    $Border.BorderThickness = [System.Windows.Thickness]::new(2)
    $Border.CornerRadius = [System.Windows.CornerRadius]::new(15)

    $Grid.Children.Add($Border)#>


    $ObjFormAbout.ShowDialog()
})
$ObjMenuItemHelp.DropDownItems.Add($ObjMenuItemAbout) > $null

$ObjMenuStrip.Items.Add($ObjMenuItemFile) > $null
$ObjMenuStrip.Items.Add($ObjMenuItemHelp) > $null
$ObjForm.Controls.Add($ObjMenuStrip) > $null


#### Status label
$ObjLabelStatus = New-Object System.Windows.Forms.Label
$ObjLabelStatus.Size = New-Object System.Drawing.Size(500, 20)
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
$ObjButtonPCInformations.Font = $StandardFont
$ObjButtonPCInformations.AutoSize = $true
$ObjButtonPCInformations.Cursor = $StandardCursor
$ObjButtonPCInformations.Add_Click({
    $ObjLabelStatus.Text = "Open text file ..."
    Open-File $PCInformations
})
$ObjForm.Controls.Add($ObjButtonPCInformations)


##### List Printers Button
$ObjButtonListPrinter = New-Object System.Windows.Forms.Button
$ObjButtonListPrinter.Location = New-Object System.Drawing.Size(135, 40)
$ObjButtonListPrinter.Text = "List Printers"
$ObjButtonListPrinter.Font = $StandardFont
$ObjButtonListPrinter.AutoSize = $true
$ObjButtonListPrinter.Cursor = $StandardCursor
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
$ObjButtonSysprep.Font = $StandardFont
$ObjButtonSysprep.AutoSize = $true
$ObjButtonSysprep.Cursor = $StandardCursor
$ObjButtonSysprep.Add_Click({
    Write-Host $NA -ForegroundColor Red
    Create-MessageBox -Title "Fehler" -Text $NA -Type Error -Button OK
})
$ObjForm.Controls.Add($ObjButtonSysprep)


##### WinGet Button
$ObjButtonWinGet = New-Object System.Windows.Forms.Button
$ObjButtonWinGet.Location = New-Object System.Drawing.Size(320, 40)
$ObjButtonWinGet.Text = "WinGet list"
$ObjButtonWinGet.Font = $StandardFont
$ObjButtonWinGet.AutoSize = $true
$ObjButtonWinGet.Cursor = $StandardCursor
$ObjButtonWinGet.Add_Click({
    $WinGet = winget list
    Open-File $WinGet
})
$ObjForm.Controls.Add($ObjButtonWinGet)


##### Process Button
$ObjButtonProcess = New-Object System.Windows.Forms.Button
$ObjButtonProcess.Location = New-Object System.Drawing.Size(410, 40)
$ObjButtonProcess.Text = "Processes"
$ObjButtonProcess.Font = $StandardFont
$ObjButtonProcess.AutoSize = $true
$ObjButtonProcess.Cursor = $StandardCursor
$ObjButtonProcess.Add_Click({
    $Process = Get-Process # | Format-Table -Property Id, @{ Label = "CPU(s)"; Expression = { $_.CPU.ToString("N") + "%" }; Alignment = "Right" }, ProcessName -AutoSize
    Open-File $Process
})
$ObjForm.Controls.Add($ObjButtonProcess)


##### Autostart folder Button
$ObjButtonAutostart = New-Object System.Windows.Forms.Button
$ObjButtonAutostart.Location = New-Object System.Drawing.Size(500, 40)
$ObjButtonAutostart.Text = "Autostart-Ordner"
$ObjButtonAutostart.Font = $StandardFont
$ObjButtonAutostart.AutoSize = $true
$ObjButtonAutostart.Cursor = $StandardCursor
$ObjButtonAutostart.Add_Click({
    $Path = Resolve-Path "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
    if (-not(Test-Path "$Path" -pathType container)) {
        Create-MessageBox -Title "Error" -Text "Der Autostart-Ordner existert nicht." -Type Error -Button OK
    }
    else {
        Start-Process $Path
    }
})
$ObjForm.Controls.Add($ObjButtonAutostart)


##### Robocopy
$ObjButtonRobocopy = New-Object System.Windows.Forms.Button
$ObjButtonRobocopy.Location = New-Object System.Drawing.Size(620, 40)
$ObjButtonRobocopy.Text = "Robocopy"
$ObjButtonRobocopy.Font = $StandardFont
$ObjButtonRobocopy.AutoSize = $true
$ObjButtonRobocopy.Cursor = $StandardCursor
$ObjButtonRobocopy.Add_Click({
    Write-Host $NA -ForegroundColor Red
    # Create-MessageBox -Title "Fehler" -Text $NA -Type Error -Button OK
    Create-Dialog -Title "Dateien kopieren erzwingen" -Text1 "Quellziel:" -Text2 "Zielpfad:"
    Write-Host $GetDialogInput1        ########################## ne
    Write-Host $InputFormTextBoxInput1 # ne
})
$ObjForm.Controls.Add($ObjButtonRobocopy)
<#
robocopy Quelleziel Zielpfad /E /ZB /R:3 /W:5 /LOG:C:\Pfad\zu\Logdatei.txt
Quelleziel: Der Pfad zum Ordner, den Sie kopieren möchten.
Zielpfad: Der Pfad zum Zielordner, in den Sie den Inhalt des fehlerhaften Ordners kopieren möchten.
/E: Kopiert auch leere Unterverzeichnisse.
/ZB: Nutzt den "Backup-Modus", um Dateien zu kopieren, selbst wenn sie im Zugriff sind.
/R:3: Versucht 3 Mal, eine Datei zu kopieren, bevor der Vorgang abgebrochen wird.
/W:5: Wartet 5 Sekunden zwischen den Versuchen.
/LOG:C:\Pfad\zu\Logdatei.txt: Speichert die Protokolldaten des Kopiervorgangs in einer Textdatei.
#>


##### Weiterer Button 2
$wbutton2 = New-Object System.Windows.Forms.Button
$wbutton2.Location = New-Object System.Drawing.Size(20, 80)
$wbutton2.Text = "net use"
$wbutton2.Font = $StandardFont
$wbutton2.AutoSize = $true
$wbutton2.Cursor = $StandardCursor
$wbutton2.Add_Click({
    $Process = net use
    Open-File $Process
})
$ObjForm.Controls.Add($wbutton2)


##### Weiterer Button 3
$wbutton3 = New-Object System.Windows.Forms.Button
$wbutton3.Location = New-Object System.Drawing.Size(110, 80)
$wbutton3.Text = "Frei"
$wbutton3.Font = $StandardFont
$wbutton3.AutoSize = $true
$wbutton3.Cursor = $StandardCursor
$wbutton3.Add_Click({
    Write-Host "b3"
})
$ObjForm.Controls.Add($wbutton3)


##### Weiterer Button 4
$wbutton4 = New-Object System.Windows.Forms.Button
$wbutton4.Location = New-Object System.Drawing.Size(200, 80)
$wbutton4.Text = "Frei"
$wbutton4.Font = $StandardFont
$wbutton4.AutoSize = $true
$wbutton4.Cursor = $StandardCursor
$wbutton4.Add_Click({
    Write-Host "b4"
})
$ObjForm.Controls.Add($wbutton4)


##### Weather Button
$ObjButtonWeather = New-Object System.Windows.Forms.Button
$ObjButtonWeather.Location = New-Object System.Drawing.Size(610, 400)
$ObjButtonWeather.Text = "Weather"
$ObjButtonWeather.Font = $StandardFont
$ObjButtonWeather.AutoSize = $true
$ObjButtonWeather.Cursor = $StandardCursor
$ObjButtonWeather.Add_Click({
    Create-Dialog -Title "Standort-Eingabe" -Text1 "Standort:" -Icon Information
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


##### Create Input dialog
function Create-Dialog($Title, $Text1, $Text2, $Icon) {
    # Create Form
    $InputForm = New-Object System.Windows.Forms.Form
    $InputForm.FormBorderStyle = "FixedSingle"
    $InputForm.MaximizeBox = $false
    $InputForm.Text = "$Title"
    $InputForm.Icon = [System.Drawing.SystemIcons]::$Icon
    $InputForm.Size = New-Object System.Drawing.Size(360, 200)
    $InputForm.StartPosition = "CenterScreen"
    $InputForm.Add_KeyDown({
        if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Escape) {
            Write-Host "Test"
            $InputForm.Close()
        }
    })


    # Location Label 1
    $InputFormLabel1 = New-Object System.Windows.Forms.Label
    $InputFormLabel1.Location = New-Object System.Drawing.Size(30, 63)
    $InputFormLabel1.Size = New-Object System.Drawing.Size(70, 20)
    $InputFormLabel1.Text = "$Text1"
    $InputForm.Controls.Add($InputFormLabel1)

    # Location Label 2
    $InputFormLabel2 = New-Object System.Windows.Forms.Label
    $InputFormLabel2.Location = New-Object System.Drawing.Size(30, 88)
    $InputFormLabel2.Size = New-Object System.Drawing.Size(70, 20)
    $InputFormLabel2.Text = "$Text2"
    $InputForm.Controls.Add($InputFormLabel2)

    # Text input 1
    $InputFormTextBoxInput1 = New-Object System.Windows.Forms.TextBox
    $InputFormTextBoxInput1.Location = New-Object System.Drawing.Size(100, 60)
    $InputFormTextBoxInput1.Size = New-Object System.Drawing.Size(200, 20)
    $InputForm.Controls.Add($InputFormTextBoxInput1)

    # Text input 2
    $InputFormTextBoxInput2 = New-Object System.Windows.Forms.TextBox
    $InputFormTextBoxInput2.Location = New-Object System.Drawing.Size(100, 85)
    $InputFormTextBoxInput2.Size = New-Object System.Drawing.Size(200, 20)
    $InputForm.Controls.Add($InputFormTextBoxInput2)

    # OK Button
    $InputFormOKButton = New-Object System.Windows.Forms.Button
    $InputFormOKButton.Location = New-Object System.Drawing.Size(190, 135)
    $InputFormOKButton.Text = "OK"
    $InputFormOKButton.Font = $StandardFont
    $InputFormOKButton.AutoSize = $true
    $InputFormOKButton.Cursor = $StandardCursor
    $InputFormOKButton.Add_Click({
        $InputForm.Close()
        $GetDialogInput1 = $InputFormTextBoxInput1
        $GetDialogInput2 = $InputFormTextBoxInput2
    })
    $InputForm.Controls.Add($InputFormOKButton)

    # Cancel Button
    $InputFormCancelButton = New-Object System.Windows.Forms.Button
    $InputFormCancelButton.Location = New-Object System.Drawing.Size(270, 135)
    $InputFormCancelButton.Text = "Abbrechen"
    $InputFormCancelButton.Font = $StandardFont
    $InputFormCancelButton.AutoSize = $true
    $InputFormCancelButton.Cursor = $StandardCursor
    $InputFormCancelButton.Add_Click({
        $InputForm.Close()
    })
    $InputForm.Controls.Add($InputFormCancelButton)

    $InputForm.AcceptButton = $InputFormOKButton
    $InputForm.ShowDialog()
}


##### Create MessageBox
function Create-MessageBox($Title, $Text, $Type, $Button) {
    [System.Windows.Forms.MessageBox]::Show($Text, $Title, [System.Windows.Forms.MessageBoxButtons]::$Button,
            [System.Windows.Forms.MessageBoxIcon]::$Type)
}


##### Close UI dialog
<#$ObjForm.Add_FormClosing({
    $Response =  Create-MessageBox -Title "HelperTool beenden" -Text "Möchten Sie HelperTool wirklich beenden?" -Type Question -Button YesNo
    if ($Response -eq "No") {
        $_.Cancel = $true
    }
})#>


##### Show UI
$ObjForm.ShowDialog()
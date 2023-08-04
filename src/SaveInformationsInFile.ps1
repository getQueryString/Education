# UI einstellen
$ObjForm = New-Object System.Windows.Forms.Form
$ObjForm.Size = New-Object System.Drawing.Size(720, 480)
$ObjForm.Text = "Ein total cooles Programm"
$ObjForm.BackColor = "white"
$ObjForm.StartPosition = "CenterScreen"




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

# Label einstellen
$ObjLabel = New-Object System.Windows.Forms.Label
$ObjLabel.Location = New-Object System.Drawing.Size(10, 10)
$ObjLabel.Size = New-Object System.Drawing.Size(350, 250)
$ObjLabel.Text = $Informations


# Label auf UI setzen
$ObjForm.Controls.Add($ObjLabel)



# Button einstellen
$ObjButton = New-Object System.Windows.Forms.Button
$ObjButton.Location = New-Object System.Drawing.Size(400, 30)
$ObjButton.Size = New-Object System.Drawing.Size(240, 20)
$ObjButton.Text = "Informationen in einer Textdatei speichern"
$ObjButton.Add_Click({


    $FolderDialog = New-Object -ComObject Shell.Application | ForEach-Object { $_.BrowseForFolder(0,
            "Bitte wählen Sie den Ort aus, wo die Informationen gespeichert werden sollen.", 0, 0) }
    if ($FolderDialog) {
        $SelectedFolder = $FolderDialog.Self.Path

        $Informations > $SelectedFolder\Informationen.txt

        [System.Windows.Forms.MessageBox]::Show("Die Informationen wurden in $SelectedFolder erfolgreich gespeichert.",
                "Informationen gespeichert", [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information)
    }


})

# Button auf UI setzen
$ObjForm.Controls.Add($ObjButton)
$ObjForm.AcceptButton = $ObjButton



# UI zeigen
$objForm.ShowDialog()
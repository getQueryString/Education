function Test-Programm {

    $ObjForm = New-Object System.Windows.Forms.Form

    $ObjForm.Backcolor = "white"
    $ObjForm.StartPosition = "CenterScreen"
    $ObjForm.Size = New-Object System.Drawing.Size(720, 480)
    $ObjForm.Text = "Ein neues Test-Fenster"

    # Label erstellen
    $ObjLabel = New-Object System.Windows.Forms.Label
    $ObjLabel.Location = New-Object System.Drawing.Size(300, 60)
    $ObjLabel.Size = New-Object System.Drawing.Size(800, 20)
    $ObjLabel.Text = "Bitte einen Text eingeben:"
    $ObjForm.Controls.Add($ObjLabel)

    # TextBox erstellen
    $ObjTextBox = New-Object System.Windows.Forms.TextBox
    $ObjTextBox.Location = New-Object System.Drawing.Size(300, 100)
    $ObjTextBox.Size = New-Object System.Drawing.Size(200, 20)
    $ObjForm.Controls.Add($ObjTextBox)

    # Button erstellen
    $ObjButton = New-Object System.Windows.Forms.Button
    $ObjButton.Location = New-Object System.Drawing.Size(300, 140)
    $ObjButton.Size = New-Object System.Drawing.Size(100, 20)
    $ObjButton.Text = "Text senden"
    $ObjButton.Add_Click({ Write-Host $ObjTextBox.Text; $ObjTextBox.Text = "" })
    $ObjForm.Controls.Add($ObjButton)

    $ObjForm.AcceptButton = $ObjButton



    [void] $objForm.ShowDialog()

}


Write-host
"Bitte starten Sie das Programm als Administrator!
    1.Rechte
    2.Prozesse
    3.IP Konfiguration
    4.Logins
    5.Security Logs
    6. Test-Programm
    "
$Eingabe = read-host -prompt "Bitte eine Zahl eingeben"

if ($Eingabe -eq '1') {
    # set-ExecutionPolicy RemoteSigned
}

elseif ($Eingabe -eq '2') {
    Get-Process
}

elseif ($Eingabe -eq '3') {
    # Get-NetIPConfiguration
}

elseif ($Eingabe -eq '4') {
    # Get-EventLog security | Where-Object {$_.TimeGenerated -gt '9/15/16'} | Where-Object {($_.InstanceID -eq 4634) -or ($_.InstanceID -eq 4624)} | Select-Object TimeGenerated,InstanceID,Message | Out-File -FilePath "c:\Logins.txt"

}

elseif ($Eingabe -eq '5') {
    # Get-EventLog Security -Newest 1000
}

elseif ($Eingabe -eq '6') {
    Test-Programm
}

else {
    write-host 'Die Eingabe ist keine Zahl zwischen 1 und 6' -foregroundcolor red
}


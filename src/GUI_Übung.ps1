<#function Test-Code {
    [CmdletBinding()]
    param(
        [int]$ParameterOne
    )
    end {
        if (10 -gt $ParameterOne) {
            "Greater"
        } else {
            "Lesser"    
        }
    }
}

$Input = Read-Host dflkj sdf sdf sd

$NameInput = read-host "Geben Sie Ihren Namen ein"
Write-Host $NameInput

# pause#>


[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
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
$ObjButton.Text = "Senden"
$ObjButton.Add_Click({ Write-Host $ObjTextBox.Text })
$ObjForm.Controls.Add($ObjButton)

$ObjForm.AcceptButton = $ObjButton



[void] $objForm.ShowDialog()






<#$Input = Read-Host "Zahl"
if($Input -eq "1") {
    Write-Host $Input
}

for ($i = 0; $i -lt 10; $i++) {
    Write-Host $Input + $i
}

Write-Host ""

$t = 1
for (;; $t++) {
    Write-Host $t
    if ($t -ge 100) {
    break;
    }
}#>
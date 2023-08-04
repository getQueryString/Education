# Dies ist ein Kommentar
Write-Host "Hello, World!"

# Variable Definieren
$name = "Fin"

# Variable nutzen
Write-Host "Hello, $name!"

# Funktion definieren
function Get-Greeting($name) {
    return "Hello, $name!"
}

# Funktion aufrufen
$greeting = Get-Greeting -name "Testname"
Write-Host $greeting

pause
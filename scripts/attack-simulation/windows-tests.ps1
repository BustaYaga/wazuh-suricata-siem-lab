# Lab-only test on victim-windows. Harmless: it only prints a message,
# but it is started the way attackers often hide commands (encoded PowerShell).
$cmd = "Write-Output 'Wazuh lab test: encoded PowerShell'"
$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($cmd))
Write-Host "[$(Get-Date -Format s)] Running encoded PowerShell test"
powershell.exe -NoProfile -EncodedCommand $encoded
Write-Host "Done. Check Wazuh for rule 100110."

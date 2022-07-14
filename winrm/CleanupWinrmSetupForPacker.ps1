
Write-Output "Removing self-signed cert from local store."
$hostName = $env:COMPUTERNAME
Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object Issuer -eq "CN=$hostName" | Remove-Item -Verbose -Force

# delete firewall rules
# print all rules: netsh advfirewall firewall show rule name=all > firewall.txt

Write-Output "Removing WinRM HTTPS firewall rule."
$RuleName = "WinRM - Powershell remoting HTTPS-In"
if (Get-NetFirewallRule | Where-Object {$_.name -eq $Rulename}) {
	Write-Output "Removing existing Winrm HTTPS Firewall rule."
	Remove-NetFirewallRule -Name $Rulename
}

Write-Output "Restoring default settings: client configurations don't allow unencrypted connections."
winrm set winrm/config/service '@{AllowUnencrypted="false"}'
winrm set winrm/config/client '@{AllowUnencrypted="false"}'

# remove it from root store
Write-Output "Removing self-signed cert that was imported in server's root store."
Get-ChildItem -Path "Cert:\LocalMachine\root" | Where-Object Issuer -eq "CN=$hostName" | Remove-Item -Verbose -Force

# delete imported certification .cer file
$certExportPath = "C:\tmp\packer-run"
Remove-Item -Path $certExportPath -Recurse
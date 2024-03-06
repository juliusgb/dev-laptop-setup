# check that powershell remoting is enabled
if (Get-ChildItem WSMan:\localhost\Listener) {
	Write-Output "PS Remoting is already enabled."
}
else {
	Write-Output "Enabling PS Remoting without checking Network profile."
	Enable-PSRemoting -SkipNetworkProfileCheck -Force
}
# configure HTTPS for WinRM, you first need to create an SSL certificate on a computer you want to connect to.
# https://docs.microsoft.com/en-us/powershell/module/pki/new-selfsignedcertificate?view=windowsserver2022-ps
$hostName = $env:COMPUTERNAME
$srvCert = New-SelfSignedCertificate -DnsName $hostName -CertStoreLocation Cert:\LocalMachine\My
Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object Issuer -eq "CN=$hostName"

# WinRM can only use one.
Write-Output "Removing Existing WinRM SSL listener."
Get-ChildItem wsman:\localhost\Listener\ | Where-Object -Property Keys -like 'Transport=HTTPS' | Remove-Item -Recurse

Write-Output "Creating new WinRM SSL listener and bind your certificate to it."
New-Item -Path WSMan:\localhost\Listener\ -Transport HTTPS -Address * -CertificateThumbPrint $srvCert.Thumbprint -Force

Write-Output "Create a Windows Firewall rule that allows WinRM HTTPS traffic or make sure that it is active."
$RuleName = "WinRM - Powershell remoting HTTPS-In"
if (Get-NetFirewallRule | Where-Object {$_.name -eq $Rulename}) {
	Write-Output "Removing existing Winrm HTTPS Firewall rule."
	Remove-NetFirewallRule -Name $Rulename
}
New-NetFirewallRule -Displayname 'WinRM - Powershell remoting HTTPS-In' -Name 'WinRM - Powershell remoting HTTPS-In' -Profile Any -LocalPort 5986 -Protocol TCP

Write-Output "Restarting the WinRM service."

Restart-Service WinRM

Write-Output "Check which certificate thumbprint te WinRM HTTPS listener is bound."
#WinRM e winrm/config/listener

Write-Output "Make winrm client connections accept unencrypted traffic."

winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/client '@{AllowUnencrypted="true"}'

Write-Output "Export cert from client machine so as to be used by server machine."
New-Item -Path C:\tmp\packer-run -ItemType Directory -Force
Export-Certificate -Cert $srvCert -FilePath C:\tmp\packer-run\SSL_PS_Remoting.cer

Write-Output "Import client cert on server into root truststore."
Import-Certificate -FilePath C:\tmp\packer-run\SSL_PS_Remoting.cer -CertStoreLocation Cert:\LocalMachine\root\

Get-ChildItem -Path "Cert:\LocalMachine\root" | Where-Object Issuer -eq "CN=$hostName" | Select-Object *


# manual checks
#  1. check that self-signed cert was saved locally
#    - on start, search Certificate -> click on pop up.
#    - top level certificat icon should show "Certificate - Local Computer"
#    - click Own Certificates -> Certificates -> One should be in there
#  2. check that cert was imported in root store
#    - on start, type regedit -> click on pop up.
#    - navigate to HKEY_LOCAL_MACHINE\Software\Microsoft\SystemCertificates\ROOT\Certificates
#  3. check that able to manually log into the machine using winrm
#    - open another powershell console and test that you can log into localhost via winrm
#    - $SessionOption = New-PSSessionOption -SkipCNCheck
#    - Enter-PSSession -Computername $env:COMPUTERNAME -UseSSL -Credential juliusg -SessionOption $SessionOption

# open another powershell console
# run packer
# C:\opt\Packer\packer_1.8.2\packer.exe build -var winrm-username=ab -var winrm-password=yz template.pkr.hcl

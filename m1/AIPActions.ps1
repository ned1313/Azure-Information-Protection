# Remove the AADRM Module if you have it
Uninstall-Module -Name AADRM

#Install the Azure AD RMS Module
Find-Module AIPService
Install-Module AIPService -Force

#Get the credentials to login
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AipService -Credential $Cred

#Review configuration of AD RMS
Get-AipServiceConfiguration 

#See other commands
Get-Command -Module AIPService
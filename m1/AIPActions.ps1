#Install the Azure AD RMS Module
Find-Module AADRM
Install-Module AADRM -Force

#Get the credentials to login
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Review configuration of AD RMS
Get-AadrmConfiguration 

#See other commands
Get-Command -Module AADRM
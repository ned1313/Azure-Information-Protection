#Run these command from an elevated PowerShell prompt
#Set scripts to allow Remote Signed
Set-ExecutionPolicy RemoteSigned

#Get credentials of a global admin
$Cred = Get-Credential

#Create a session with Exchange Online
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic –AllowRedirection
Import-PSSession $Session
Get-IRMConfiguration

#Enable IRM if it's not already enabled
Set-IRMConfiguration -AzureRMSLicensingEnabled $true

#Install the Azure AD RMS Module
Find-Module AADRM
Install-Module AADRM -Force

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Enable the super user feature
Get-AadrmSuperUserFeature
Enable-AadrmSuperUserFeature

Add-AadrmSuperUser -EmailAddress "MaGarber@contoso-ned.xyz"

#Prepare Azure Key Vault
#Install Azure PowerShell
Find-Module AzureRM
Install-Module AzureRM -Force

#Log into Azure and get subscription
Add-AzureRMAccount
Get-AzureRMSubscription





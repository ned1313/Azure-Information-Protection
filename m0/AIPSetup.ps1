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

#Create a Resource Group
$ResourceGroup = Read-Host -Prompt "Resource Group Name"
$Location = Read-Host -Prompt "Location for Resource Group and Key Vault"
New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location

#Create a Key Vault
$Vault = Read-Host -Prompt "Vault Name"
New-AzureRmKeyVault -Name $Vault -ResourceGroupName $ResourceGroup -Location $Location -Sku Standard

#Create a Key
$key = Add-AzureKeyVaultKey -VaultName $Vault -Name "contoso-aip-key" -Destination Software -Size 2048

#Configure Vault Access
Set-AzureRmKeyVaultAccessPolicy -VaultName $vault -ResourceGroupName $ResourceGroup -ServicePrincipalName 00000012-0000-0000-c000-000000000000 -PermissionsToKeys decrypt,sign,get

#Configure BYOK
Use-AadrmKeyVaultKey -KeyVaultKeyUrl $key.Id

#Get the AADRM Keys
Get-AadrmKeys
#Set the new key as active
Set-AadrmKeyProperties -KeyIdentifier "[Key ID]" -Active:$true




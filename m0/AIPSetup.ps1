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
Find-Module AIPService
Install-Module AIPService -Force

#Connect to the Azure AD RMS Service
Connect-AipService -Credential $Cred

#Enable the super user feature
Get-AadrmSuperUserFeature
Enable-AadrmSuperUserFeature

Add-AadrmSuperUser -EmailAddress "MaGarber@contoso-ned.xyz"

#Prepare Azure Key Vault
#Install Azure PowerShell
Find-Module Az
Install-Module Az -Force

#Log into Azure and get subscription
Add-AzAccount
Get-AzSubscription

#Create a Resource Group
$ResourceGroup = Read-Host -Prompt "Resource Group Name"
$Location = Read-Host -Prompt "Location for Resource Group and Key Vault"
New-AzResourceGroup -Name $ResourceGroup -Location $Location

#Create a Key Vault
$Vault = Read-Host -Prompt "Vault Name"
New-AzKeyVault -Name $Vault -ResourceGroupName $ResourceGroup -Location $Location -Sku Standard

#Create a Key
$key = Add-AzKeyVaultKey -VaultName $Vault -Name "contoso-aip-key" -Destination Software -Size 2048

#Configure Vault Access
Set-AzKeyVaultAccessPolicy -VaultName $vault -ResourceGroupName $ResourceGroup -ServicePrincipalName 00000012-0000-0000-c000-000000000000 -PermissionsToKeys decrypt,sign,get

#Configure BYOK
Use-AipServiceKeyVaultKey -KeyVaultKeyUrl $key.Id

#Get the AIP Service Keys
Get-AipServiceKeys
#Set the new key as active
Set-AipServiceKeyProperties -KeyIdentifier "[Key ID]" -Active:$true




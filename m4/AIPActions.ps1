#Get credentials of a global admin
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AipService -Credential $Cred

#Get the commands
Get-Command "*aipservicekey*"

#Get the AIP Service Keys
Get-AipServiceKeys

#Update the key to Microsoft managed
$key = (Get-AipServiceKeys) | Sort-Object CreationTime | Select-Object -First 1

Set-AipServiceKeyProperties -KeyIdentifier $key.KeyIdentifier.Guid -Active:$true
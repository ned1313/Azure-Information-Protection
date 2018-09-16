#Get credentials of a global admin
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Get the commands
Get-Command "*aadrmkey*"

#Get the AADRM Keys
Get-AadrmKeys

#Update the key to Microsoft managed
$key = (Get-AadrmKeys) | Sort-Object CreationTime | Select-Object -First 1

Set-AadrmKeyProperties -KeyIdentifier $key.KeyIdentifier.Guid -Active:$true




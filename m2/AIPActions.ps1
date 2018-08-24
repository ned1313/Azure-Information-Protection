#Get the credentials to login
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Template Commands
Get-Command -Module AADRM *Template*

#Get All templates
Get-AadrmTemplate

#Remove the LSI Template (Label)
Remove-AadrmTemplate -TemplateId "template ID"

#Create a new template
$names = @{}
$names[1033] = "Grey Jay - Confidential content"
$descriptions = @{}
$descriptions[1033] = "This content is confidential for people working in Grey Jay and should not be shared externally"
$r1 = New-AadrmRightsDefinition -DomainName "contoso-ned.xyz" -Rights "VIEW","EXPORT"
$r2 = New-AadrmRightsDefinition -EmailAddress "JoMcGee@contoso-ned.xyz" -Rights "OWNER"
Add-AadrmTemplate -Names $names -Descriptions $Descriptions -LicenseValidityDuration 5 -RightsDefinitions $r1, $r2 -Status Published
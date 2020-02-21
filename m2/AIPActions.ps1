#Get the credentials to login
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AipService -Credential $Cred

#Template Commands
Get-Command -Module AIPService *Template*

#Get All templates
Get-AadrmTemplate

#Remove the LSI Template (Label)
Remove-AadrmTemplate -TemplateId "84c21a71-43b1-449e-873c-4c65c5c7fd33"

#Create a new template
$names = @{}
$names[1033] = "Grey Jay - Highly Confidential content"
$descriptions = @{}
$descriptions[1033] = "This content is highly confidential for people working in Grey Jay and should not be shared externally"
$r1 = New-AadrmRightsDefinition -DomainName "contoso-ned.xyz" -Rights "VIEW","EXPORT"
$r2 = New-AadrmRightsDefinition -EmailAddress "JoMcGee@contoso-ned.xyz" -Rights "OWNER"
Add-AadrmTemplate -Names $names -Descriptions $Descriptions -LicenseValidityDuration 5 -RightsDefinitions $r1, $r2 -Status Published
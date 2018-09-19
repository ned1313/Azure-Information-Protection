#Get credentials of a global admin
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Get all super user commands
Get-Command "*SuperUser*"

#Check the super user feature
Get-AadrmSuperUserFeature

#Get all super users
Get-AadrmSuperUser
Get-AadrmSuperUserGroup

#Remove a super user
Remove-AadrmSuperUser -EmailAddress "MaGarber@contoso-ned.xyz"

#Add a super user
Add-AadrmSuperUser -EmailAddress "JoMcGee@contoso-ned.xyz"
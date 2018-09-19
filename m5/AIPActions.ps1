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

#Set a super user group
Set-AadrmSuperUserGroup -GroupEmailAddress "328d61fc7d@nedinthecloud.onmicrosoft.com"
#Get credentials of a global admin
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AipService -Credential $Cred

#Get all super user commands
Get-Command -Module AIPService "*SuperUser*"

#Check the super user feature
Get-AipServiceSuperUserFeature

#Get all super users
Get-AipServiceSuperUser
Get-AipServiceSuperUserGroup

#Remove a super user
Remove-AipServiceSuperUser -EmailAddress "MaGarber@contoso-ned.xyz"

#Set a super user group
Set-AipServiceSuperUserGroup -GroupEmailAddress "328d61fc7d@nedinthecloud.onmicrosoft.com"
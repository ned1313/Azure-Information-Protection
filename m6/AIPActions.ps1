#Get credentials of a global admin
$Cred = Get-Credential

#Connect to the Azure AD RMS Service
Connect-AadrmService -Credential $Cred

#Check out the current config
Get-AadrmConfiguration

#Get all log commands
Get-Command "*Log*" -Module AADRM

#Create a directory for user logs
$userLogDir = "C:\AIPUserLogs"
mkdir -Path $userLogDir

#Install LogParser if you have Chocolately
#Use an elevated shell
choco install logparser -y

#Get the user logs for the last 30 days
Get-AadrmUserLog -Path $userLogDir -FromDate (Get-Date).AddDays(-30)

#User logparser to convert to CSV
cd "C:\Program Files (x86)\Log Parser 2.2"
.\LogParser.exe -i:W3C -o:csv "Select * INTO C:\AIPUserLogs\AIPLogs.csv FROM C:\AIPUserLogs\*.log"
$results = Import-Csv -Path $userLogDir\AIPLogs.csv
$results | Where-Object {$_.'user-id' -like "*MaGarber*"} | Format-Table

#Get the admin logs
$adminLogDir = "C:\AIPAdminLogs"
mkdir $adminLogDir
Get-AadrmAdminLog -Path $adminLogDir\adminLogs.log

#Convert log to CSV sorta
$results = Import-Csv -Header Timestamp,User, Action, Status, Info -Path $adminLogDir\adminLogs.log -Delimiter "`t"
$results | Where-Object{$_.Action -like "*superuser*"} | Format-Table

#Get Document Tracking
Get-AadrmDocumentTrackingFeature

Get-AadrmDocumentLog -UserEmail "MaGarber@contoso-ned.xyz" -FromTime (get-date).AddDays(-10)
Get-AadrmTrackingLog -UserEmail "MaGarber@contoso-ned.xyz"


# These commands should be run from a system that has the 
# Azure Information Protection Client installed

#Get all commands in the module
Get-Command -Module AzureInformationProtection

#Get the current RMS Server
Get-RMSServer

#Get the available RMS Templates
Get-RMSTemplate

#Check the status of an existing file
Get-AIPFileStatus .\CallLog.xlsx

#Copy a file and change label
#You'll need to find the label ID ahead of time
#from the portal.
Copy-Item .\CallLog.xlsx .\CallLog_Public.xlsx
Set-AIPFileLabel -LabelId 5879f962-6c60-4db0-a8ee-094feef0327d -Path .\CallLog_Public.xlsx
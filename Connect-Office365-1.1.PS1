<# 

.SYNOPSIS
	Purpose of this script to connect to Office 365 Exchange Online and Azure Active Directory.


.DESCRIPTION
	Very simple script to connect to Office 365.  Uploaded to gallery for reference. 


.ASSUMPTIONS
    
    WinRM 2.0 is installed on the machine where script is executing. 

    Azure Active Directory Module has been downloaded and installed with it's prerequisites. 
    Please see:
    https://technet.microsoft.com/en-us/library/jj151815.aspx?f=255&MSPPError=-2147217396 

    The credentials you provide have access to Windows Azure Active Directory and Exchange Online.  

    Same credential will be used for Azure AD, and Exchange Online. 

	You can live with the Write-Host cmdlets :) 

	You can add your error handling if you need it.  

	

.VERSION
  
	1.0  6-6-2015   -- Initial script released to the scripting gallery 
	1.1  17-11-2016 -- Changed the clean up PSSSession reminder text from Red to Magenta, as Red scared Darren a little.....


.Disclaimer

This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.  
THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.  
We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object code form of the Sample Code, 
provided that You agree: 
(i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded; 
(ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and 
(iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the Sample Code.
Please note: None of the conditions outlined in the disclaimer above will supercede the terms and conditions contained within the Premier Customer Services Description.
This posting is provided "AS IS" with no warranties, and confers no rights. 

Use of included script samples are subject to the terms specified at http://www.microsoft.com/info/cpyright.htm.

#>

# Prompt For Credentials
$Cred = Get-Credential

# Connect to WAAD
Import-Module MSOnline

Write-Host "Connecting To Azure Active Directory...." -ForegroundColor Green 
Connect-MSOLService -Credential $Cred 


# Connect to Exchange Online Using Remote PowerShell
# Define the session parameters.  Auth needs to be basic.  
# Since we are connecting to the well known URL (ps.outlook.com) need to then allow redirection to the specific pod where the tenant is currently running from.
Write-Host "Connecting To Exchange Online..." -ForegroundColor Green 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Cred -Authentication Basic -AllowRedirection

# Finally import the session to avail ourselves of the cmdlets....
$Session = Import-PSSession $Session


Write-host "The following PowerShell Sessions Are Present:" -ForegroundColor Green 
Get-PSSession 

Write-Host
Write-Host
Write-Host "Be sure to disconnect the EXO Remote PowerShell session (ID specified above) when done.  Use Remove-PSSession" -ForegroundColor Magenta
Write-Host
Write-Host "Have a nice day!"
Write-Host 
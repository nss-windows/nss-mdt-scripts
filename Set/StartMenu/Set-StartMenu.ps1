<#
.SYNOPSIS
Set a default Start Menu layout for all new accounts.

.DESCRIPTION
This script will import a Start Menu layout to use as the default template. The template is only applied to new accounts.

It is assumed the script is in the same directory as the layout template to be applied.

.NOTES   
Name       : Set-StartMenu.ps1
Author     : Darren Hollinrake
Version    : 1.0
DateCreated: 2018-02-20
DateUpdated: 2020-03-24

.PARAMETER Layout
Specify the name of the template file to be used.

.PARAMETER LayoutLocation
Specify the location of the template file if it is not in the same directory as the script. Do not include the name of the template file.

.EXAMPLE
Set-StartMenu.ps1
Import the default template of StartMenu.xml which is located in the same directory as the script.

.EXAMPLE
Set-StartMenu.ps1 -Template "StartMenu.xml"
Imports the template named "StartMenu.xml" which is located in the same directory as the script.

.EXAMPLE
Set-StartMenu.ps1 -LayoutLocation "C:\NSS\StartMenu\" -Template "StartMenu.xml"
Imports the template named "StartMenu.xml" located in the "C:\NSS\StartMenu\" directory.

#>
[CmdletBinding()]

Param (
  [Parameter(HelpMessage = "Select the template xml file.")]
  [Alias("Template")]
  [String]$Layout = "StartMenu.xml",
  [Parameter(HelpMessage = "Set the path to the template file. If not specified, the script location is used.")]
  [Alias("TemplateLocation")]
  [String]$LayoutLocation = ""
)

$LogPath = "C:\NSS\Logs\"
If (!(Test-Path "$LogPath")) { New-Item -ItemType Directory -Force -Path "$LogPath" }
$scriptname = [io.path]::GetFileNameWithoutExtension("$($MyInvocation.MyCommand.Name)")
$TransactionLog = $LogPath + $(Get-Date -Format yyyyMMdd) + "_" + $scriptname + ".log"
Start-Transcript -LiteralPath $TransactionLog
Write-Verbose "PSScriptRoot: $PSScriptRoot"
If ($LayoutLocation -eq "") {
    Write-Verbose "LayoutLocation is empty, setting to PSScriptRoot"
    $LayoutLocation = "$PSScriptRoot"
}
Write-Verbose "LayoutLocation: $LayoutLocation"

# Full path to the location of the template file.
$LayoutPath = Join-Path -Path "$LayoutLocation" -ChildPath "$Layout"
Write-Verbose "LayoutPath: $LayoutPath"

Import-StartLayout -LayoutPath "$LayoutPath" -MountPath "$env:SystemDrive\" -Verbose

# Need to copy the IE link to a location available to all users otherwise it won't be pinned
Copy-Item -Path "$PSScriptRoot\Internet Explorer.lnk" -Destination "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Accessories" -Verbose

Stop-Transcript
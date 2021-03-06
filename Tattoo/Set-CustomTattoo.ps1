﻿<#
.SYNOPSIS
Sets custom tattoo based on the task sequence being ran.

.DESCRIPTION
This script created registry keys and a custom 'buildinfo.txt' file at the root of the 'C:\' drive. 

.NOTES   
Name       : Set-CustomTattoo.ps1
Author     : Darren Hollinrake
Version    : 1.0
DateCreated: 2018-02-20
DateUpdated: 2020-05-21

MDT Use:
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
Type: PowerShell Script
Name: Set Custom Tattoo
PowerShell script: %SCRIPTROOT%\nss-mdt-scripts\Tattoo\Set-CustomTattoo.ps1

#>

# Apply a registry key for the date of capture
reg add "HKLM\SOFTWARE\Microsoft\Deployment 4" /v "Capture Date" /t REG_SZ /d (Get-Date -Format yyyy-MM-dd)
# Convert existing timestamp property to usable format
#$BuildDate = "Build Date:`t" + [datetime]::parseexact(((Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Timestamp").Substring(0,8), "yyyyMMdd",$null)
#
# Create a build file
If(!(Test-Path "$env:SystemDrive\buildinfo.txt")) {
    New-Item -ItemType "file" -Path "$env:SystemDrive\buildinfo.txt"
    }

$TaskSequenceID = "ID:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Task Sequence ID"
$TaskSequenceName = "Release:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Task Sequence Name"
$TaskSequenceVersion = "Version:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Task Sequence Version"
$BuildDate = "Build Date:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Date"

$TaskSequenceID | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
$TaskSequenceName | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
$TaskSequenceVersion | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
$BuildDate | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
#endregion Buildinfo File

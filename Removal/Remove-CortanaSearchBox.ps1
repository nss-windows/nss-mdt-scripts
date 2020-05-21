<#
.SYNOPSIS
Removes the Cortana Search box from the taskbar.

.DESCRIPTION
Removes the Cortana Search box from the taskbar.

.NOTES
Name            : Remove-CortanaSearchBox.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2019-08-31
Date Updated    : 2020-05-21

MDT Use:
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
Type: PowerShell Script
Name: Remove Cortana Search Box
PowerShell script: %SCRIPTROOT%\nss-mdt-scripts\Removal\Remove-CortanaSearchBox.ps1

#>

# Hide Cortana search box from the taskbar
reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg unload "HKU\TEMP"
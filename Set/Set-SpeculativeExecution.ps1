<#
.SYNOPSIS
Set the registry keys necessary to mitigate speculative execution.

.DESCRIPTION
The script creates the registry keys and values needed to enable mitigations for speculative execution (Spectre/Meltdown).

These setting are for Intel processors with hyperthreading enabled. If hyperthreading is disabled, change the value of'FeatureSettingsOverride' to '8264'

.NOTES   
Name       : Set-SpeculativeExecution.ps1
Author     : Darren Hollinrake
Version    : 1.0
DateCreated: 2020-03-20
DateUpdated: 

#>

#region Logging
###############
#   Logging   #
###############
$LogPath = "C:\NSS\Logs\"
If (!(Test-Path "$LogPath")) {New-Item -ItemType Directory -Force -Path "$LogPath"}
$ScriptName = [io.path]::GetFileNameWithoutExtension("$($MyInvocation.MyCommand.Name)")
$TransactionLog = $LogPath + $(Get-Date -Format yyyyMMdd) + "_" + $ScriptName + ".log"
Start-Transcript -LiteralPath $TransactionLog
#endregion

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 72 /f

Stop-Transcript
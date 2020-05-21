# Remove the OneDrive installer and the registry key that tells it to run once.

# Stop the OneDrive process so we can uninstall it
Get-Process -Name "OneDrive" | Stop-Process
Start-Process -FilePath "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait

# Remove the installer from the system
takeown /F "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" /A
icacls "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" /Grant Administrators:`(F`)
Remove-Item "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" -Force
Remove-Item "$env:ProgramData\Microsoft OneDrive" -Recurse -Force

# Stop RunOnce from launching the installer
reg load "HKLM\WIM" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg delete "HKLM\WIM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f
reg unload "HKLM\WIM"

#region Cleanup

# Remove Explorer link
reg add "HKCR\CLSID{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f
# Remove Start Menu link
Remove-Item -Force "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
# Remove Scheduled Task
Get-ScheduledTask -TaskName "OneDrive*" | Unregister-ScheduledTask -Confirm:$false

#endregion

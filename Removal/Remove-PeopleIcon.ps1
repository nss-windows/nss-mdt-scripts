reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f
reg unload "HKU\TEMP"
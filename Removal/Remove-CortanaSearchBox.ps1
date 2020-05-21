# Hide Cortana search box from the taskbar
reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg unload "HKU\TEMP"
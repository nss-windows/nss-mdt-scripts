reg add "HKLM\Software\Policies\Microsoft\NetBanner" /f /t REG_DWORD /v CustomBackgroudColor /d 5
reg add "HKLM\Software\Policies\Microsoft\NetBanner" /f /t REG_DWORD /v CustomForeColor /d 3
reg add "HKLM\Software\Policies\Microsoft\NetBanner" /f /t REG_DWORD /v CustomSettings /d 1
reg add "HKLM\Software\Policies\Microsoft\NetBanner" /f /t REG_SZ /v CustomDisplayText /d "No Classification Set! Set NetBanner GPO."
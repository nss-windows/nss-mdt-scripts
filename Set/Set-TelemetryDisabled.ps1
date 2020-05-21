# Set Telemetry options to disable collection
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /f /t REG_DWORD /v AllowTelemetry /d 0
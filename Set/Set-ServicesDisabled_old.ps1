# Disable unnecessary services
$services = @("XblAuthManager",
            "XblGameSave",
            "XboxNetApiSvc",
            "bthserv",
            "BthHFSrv",
            "lfsvc",
            "Fax",
            "PhoneSvc",
            "icssvc",
            "MapsBroker",
            "WMPNetworkSvc")

Get-Service $services | Stop-Service -passthru | Set-Service -startuptype disabled -Verbose

# Access denied if attempted using above command
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\xbgm"  /f /t REG_DWORD /v Start /d 4
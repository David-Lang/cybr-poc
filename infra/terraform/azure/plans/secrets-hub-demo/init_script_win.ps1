# install AZ cli for powershell

###-----

New-Item -Path "C:\init_started.txt" -ItemType File | Out-Null

###-----

Start-Transcript -Append C:\init_log.txt
#start-sleep -s 90
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

###-----

# Download and install NuGet
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

###-----

# Download and install PowerShell 7.4
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi -OutFile $env:TEMP\PowerShell-7.4.0-win-x64.msi
Start-Process -Wait -FilePath msiexec -ArgumentList "/i $env:TEMP\PowerShell-7.4.0-win-x64.msi /quiet /qn /norestart"
#Remove-Item $env:TEMP\PowerShell-7.4.0-win-x64.msi


# set ssh defualt shell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

###-----

# install azure cli
Install-Module -Name Az -AllowClobber -Scope CurrentUser -force

###-----

New-Item -Path "C:\init_completed.txt" -ItemType File | Out-Null

###-----

Stop-Transcript
#Restart-Computer -ComputerName localhost -Force
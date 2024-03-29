data "template_file" "userdata" {
  template = <<EOF
<powershell>

###-----

New-Item -Path "C:\init_started.txt" -ItemType File | Out-Null

###-----

Start-Transcript -Append C:\init_log.txt
#start-sleep -s 90
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

## Set Admin Pass
$NewPassword = ConvertTo-SecureString "${var.lab_pwd}" -AsPlainText -Force
Set-LocalUser -Name "Administrator" -Password $NewPassword

### Restart Amazon SSM Agent
#Restart-Service AmazonSSMAgent

###-----

# Download and install NuGet
Invoke-WebRequest -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile C:\NuGet.exe

# Download and install PowerShell 7.4
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi -OutFile $env:TEMP\PowerShell-7.4.0-win-x64.msi
Start-Process -Wait -FilePath msiexec -ArgumentList "/i $env:TEMP\PowerShell-7.4.0-win-x64.msi /quiet /qn /norestart"
#Remove-Item $env:TEMP\PowerShell-7.4.0-win-x64.msi

###-----

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd
Get-Service sshd

# set ssh defualt shell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

$sshdConfigPath = "C:\ProgramData\ssh\sshd_config"
$sshdConfigContent = Get-Content -Path $sshdConfigPath
$sshdConfigContent = $sshdConfigContent -replace "#PubkeyAuthentication yes", "PubkeyAuthentication yes"
$sshdConfigContent | Set-Content -Path $sshdConfigPath

###-----

# requires powershell 7
# ssh-keygen -t ed25519 -f $env:USERPROFILE\.ssh\id_ed25519 -N ""

###-----

## Define the file path
#New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh\" | Out-Null
#$filePath = "$env:USERPROFILE\.ssh\openssh.pub"
#$fileContent = @"
#${base64decode(var.public_key_openssh_b64)}
#"@
#Set-Content -Path $filePath -Value $fileContent
#
## Output a message indicating that the file has been created
#Write-Host "File created at: $filePath"

###-----

# By default the ssh-agent service is disabled. Configure it to start automatically.
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent

# Now load your key files into ssh-agent
#ssh-add $env:USERPROFILE\.ssh\openssh.pub
#ssh-add $env:ProgramData\ssh\administrators_authorized_keys

# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\rsa.pub
Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '${base64decode(var.public_key_openssh_b64)}'
icacls.exe "$env:ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"

###-----

## Install NuGet packages required by PSSharedGoods
#Start-Process -Wait -FilePath C:\NuGet.exe -ArgumentList "install PSSharedGoods -OutputDirectory C:\Program Files\WindowsPowerShell\Modules"

## Enable SSH remoting for PowerShell
#Install-Module -Name PSSharedGoods -Force -Confirm:$false
#Install-Module -Name Posh-SSH -Force -Confirm:$false
#Enable-SSHRemoting -Force

###-----

New-Item -Path "C:\init_completed.txt" -ItemType File | Out-Null

###-----

Stop-Transcript
#Restart-Computer -ComputerName localhost -Force
</powershell>
EOF
}
data "template_file" "userdata" {
  template = <<EOF
<powershell>

Start-Transcript -Append C:\PSScriptLog.txt
start-sleep -s 90
Set-ExecutionPolicy Bypass -Scope process

## Set Admin Pass
$NewPassword = ConvertTo-SecureString "${var.lab_pwd}" -AsPlainText -Force
Set-LocalUser -Name "Administrator" -Password $NewPassword

## Restart Amazon SSM Agent
Restart-Service AmazonSSMAgent

Stop-Transcript
Restart-Computer -ComputerName localhost -Force
</powershell>
EOF
}
data "aws_ami" "win_server" {
  most_recent = true
  name_regex  = "EC2LaunchV2-Windows_Server-2019-English-Full-Base"
  owners      = ["801119661308"] # Amazon

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

output "synchronizer_ami_id" {
  value = data.aws_ami.win_server.id
}

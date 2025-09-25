output "compute_public_ip" {
  value = aws_eip.compute_vm.public_ip
}

output "compute_private_ip" {
  value = aws_eip.compute_vm.private_ip
}

output "compute_fqdn" {
  value = aws_eip.compute_vm.public_dns
}

output "compute_user_data" {
  value = data.template_file.compute_user_data.rendered
}

output "compute_os_user" {
  value = "ec2-user"
}

output "compute_iam_role_arn" {
  value = aws_iam_role.iam_authn_role.arn
}

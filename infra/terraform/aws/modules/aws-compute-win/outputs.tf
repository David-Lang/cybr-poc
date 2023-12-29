output "compute_public_ip" {
  value = aws_eip.compute.public_ip
}

output "compute_private_ip" {
  value = aws_eip.compute.private_ip
}

output "compute_fqdn" {
  value = aws_eip.compute.public_dns
}

output "compute_os_user" {
  value = "administrator"
}

output "compute_public_key" {
  value = data.aws_key_pair.lab_key_pair.public_key
}

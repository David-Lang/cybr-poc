output "compute_public_ip" {
  value = module.aws-compute-ubuntu.compute_public_ip
}

output "compute_private_ip" {
  value = module.aws-compute-ubuntu.compute_private_ip
}

output "compute_fqdn" {
  value = module.aws-compute-ubuntu.compute_fqdn
}

output "compute_os_user" {
  value = "ubuntu"
}

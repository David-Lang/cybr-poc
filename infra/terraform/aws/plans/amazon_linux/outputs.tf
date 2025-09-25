output "compute_public_ip" {
  value = module.aws-compute-aws-linux.compute_public_ip
}

output "compute_private_ip" {
  value = module.aws-compute-aws-linux.compute_private_ip
}

output "compute_fqdn" {
  value = module.aws-compute-aws-linux.compute_fqdn
}

output "compute_os_user" {
  value = module.aws-compute-aws-linux.compute_os_user
}

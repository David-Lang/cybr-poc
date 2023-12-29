output "aws_identity_arn" {
  value     = data.aws_caller_identity.current.arn
  sensitive = false
}

output "compute_public_ip" {
  value = module.aws-compute-win.compute_public_ip
}

output "compute_private_ip" {
  value = module.aws-compute-win.compute_private_ip
}

output "compute_fqdn" {
  value = module.aws-compute-win.compute_fqdn
}

output "compute_os_user" {
  value = "administrator"
}

output "compute_public_key" {
  value = module.aws-compute-win.compute_public_key
}

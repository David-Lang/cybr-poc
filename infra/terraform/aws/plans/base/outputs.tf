output "aws_identity_arn" {
  value     = data.aws_caller_identity.current.arn
  sensitive = false
}

output "vpc_private_subnet_ids" {
  value     = "[\\\"${join("\\\",\\\"", module.aws-vpc.vpc_private_subnet_ids)}\\\"]"
  sensitive = false
}

output "vpc_public_subnet_ids" {
  value     = "[\\\"${join("\\\",\\\"", module.aws-vpc.vpc_public_subnet_ids)}\\\"]"
  sensitive = false
}

output "vpc_allowlist_sg_id" {
  value     = module.aws-allowlist_sg.allowlist_public_sg_id
  sensitive = false
}

output "base_tags_json" {
  value     = replace(jsonencode(local.base_tags), "\"", "\\\"")
  sensitive = false
}

output "isp_sub_domain" {
  value     = var.isp_sub_domain
  sensitive = false
}

output "name_prefix" {
  value     = local.name_prefix
  sensitive = false
}

#output "terraform_cloud_org_name" {
#  value     = var.terraform_cloud_org_name
#  sensitive = false
#}
#
#output "terraform_cloud_prj_id" {
#  value     = var.terraform_cloud_prj_id
#  sensitive = false
#}

output "vpc_id" {
  value     = module.aws-vpc.vpc_id
  sensitive = false
}

output "vpc_cidr" {
  value     = local.vpc_cidr
  sensitive = false
}

output "keypair_name" {
  value     = aws_key_pair.new-keypair.key_name
  sensitive = false
}

output "keypair_public_key_openssh" {
  value     = tls_private_key.new_key.public_key_openssh
  sensitive = false
}

output "keypair_private_key_openssh" {
  value     = tls_private_key.new_key.private_key_openssh
  sensitive = true
}

#output "push_base_varset_request_body" {
#  value     = data.http.push_base_varset.request_body
#  sensitive = false
#}
#
#
#output "push_base_varset_response_body" {
#  value     = data.http.push_base_varset.response_body
#  sensitive = false
#}

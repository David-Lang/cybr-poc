data "aws_caller_identity" "current" {}

data "conjur_secret" "aws_access_key" {
  name = var.conjur_id_aws_access_key
}

data "conjur_secret" "aws_secret_key" {
  name = var.conjur_id_aws_secret_key
}

data "template_file" "varset_json" {
  template = file("${path.module}/varset.tftpl.json")
  vars = {
    aws_region               = var.aws_region
    base_tags_json           = replace(jsonencode(local.base_tags), "\"", "\\\"")
    isp_sub_domain           = var.isp_sub_domain
    keypair_name             = aws_key_pair.new-keypair.key_name
    name_prefix              = local.name_prefix
    private_key_openssh_b64  = base64encode(tls_private_key.new_key.private_key_openssh)
    public_key_openssh_b64   = base64encode(tls_private_key.new_key.public_key_openssh)
    terraform_cloud_api_key  = var.terraform_cloud_api_key
    terraform_cloud_org_name = var.terraform_cloud_org_name
    terraform_cloud_prj_id   = var.terraform_cloud_prj_id
    terraform_cloud_prj_id   = var.terraform_cloud_prj_id
    vpc_allowlist_sg_id      = module.aws-allowlist_sg.allowlist_public_sg_id
    vpc_cidr                 = local.vpc_cidr
    vpc_id                   = module.aws-vpc.vpc_id
    vpc_private_subnet_ids   = "[\\\"${join("\\\",\\\"", module.aws-vpc.vpc_private_subnet_ids)}\\\"]"
    vpc_public_subnet_ids    = "[\\\"${join("\\\",\\\"", module.aws-vpc.vpc_public_subnet_ids)}\\\"]"
  }
}

data "template_file" "base_tfvars" {
  template = file("${path.module}/secrets.base.auto.tfvars.tmpl.out")
  vars = {
    aws_region               = var.aws_region
    base_tags_json           = replace(jsonencode(local.base_tags), "\"", "\\\"")
    isp_sub_domain           = var.isp_sub_domain
    keypair_name             = aws_key_pair.new-keypair.key_name
    name_prefix              = local.name_prefix
    private_key_openssh_b64  = base64encode(tls_private_key.new_key.private_key_openssh)
    public_key_openssh_b64   = base64encode(tls_private_key.new_key.public_key_openssh)
    vpc_allowlist_sg_id      = module.aws-allowlist_sg.allowlist_public_sg_id
    vpc_cidr                 = local.vpc_cidr
    vpc_id                   = module.aws-vpc.vpc_id
    vpc_private_subnet_ids   = "[\"${join("\",\"", module.aws-vpc.vpc_private_subnet_ids)}\"]"
    vpc_public_subnet_ids    = "[\"${join("\",\"", module.aws-vpc.vpc_public_subnet_ids)}\"]"
  }
}

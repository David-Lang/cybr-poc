module "aws-compute-win" {
  source                = "../../modules/aws-compute-win"
  allowlist_sg_id       = var.vpc_allowlist_sg_id
  aws_region            = var.aws_region
  common_tags           = local.common_tags
  compute_name          = "dpa1"
  keypair_name          = var.keypair_name
  lab_pwd               = var.lab_pwd
  name_prefix           = local.name_prefix
  public_subnet_id      = var.vpc_public_subnet_ids[0]
  vpc_cidr              = var.vpc_cidr
  vpc_id                = var.vpc_id
  compute_instance_type = "t2.medium"
}
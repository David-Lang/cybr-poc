module "aws-compute-aws-linux" {
  source                = "../../modules/aws-compute-aws-linux-2023"
  keypair_name          = var.keypair_name
  name_prefix           = local.name_prefix
  common_tags           = local.common_tags
  compute_name          = var.compute_name
  compute_instance_type = "t3a.small"
  vpc_id                = var.vpc_id
  vpc_cidr              = var.vpc_cidr
  public_subnet_id      = var.vpc_public_subnet_ids[0]
  allowlist_sg_id       = var.vpc_allowlist_sg_id
}

module "lab-aws-eks" {
  source          = "../../modules/aws-eks"
  aws_region      = var.aws_region
  name_prefix     = local.name_prefix
  plan_name       = var.plan_name
  common_tags     = local.common_tags
  vpc_id          = var.vpc_id
  private_subnets = var.vpc_private_subnet_ids
  vpc_cidr        = var.vpc_cidr
  keypair_name    = var.keypair_name
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

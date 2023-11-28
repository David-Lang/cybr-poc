module "aws-vpc" {
  source                  = "../../modules/aws-vpc"
  aws_region              = var.aws_region
  name_prefix             = local.name_prefix
  plan_name               = ""
  common_tags             = local.common_tags
  vpc_cidr = local.vpc_cidr
  public_subnets = local.public_subnets
  private_subnets = local.private_subnets
  # enable nat gateway for lambda traffic if needed
  enable_nat_gateway = false
}
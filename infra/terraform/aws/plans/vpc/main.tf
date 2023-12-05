module "aws-vpc" {
  source          = "../../modules/aws-vpc"
  aws_region      = var.aws_region
  name_prefix     = local.name_prefix
  plan_name       = ""
  common_tags     = local.common_tags
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
  # enable nat gateway for lambda traffic if needed
  enable_nat_gateway       = false
  terraform_cloud_api_key  = var.terraform_cloud_api_key
  terraform_cloud_org_name = var.terraform_cloud_org_name
  terraform_cloud_ws_id    = var.terraform_cloud_ws_id
}
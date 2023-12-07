module "aws-vpc" {
  source          = "../../modules/aws-vpc"
  aws_region      = var.aws_region
  name_prefix     = local.name_prefix
  plan_name       = var.plan_name
  common_tags     = local.common_tags
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
  # enable nat gateway for lambda traffic if needed
  enable_nat_gateway = false
  terraform_cloud_api_key  = var.terraform_cloud_api_key
  terraform_cloud_org_name = var.terraform_cloud_org_name
  terraform_cloud_ws_id    = var.terraform_cloud_ws_id
}

module "aws-allowlist_sg" {
  source              = "../../modules/aws-allowlist-sg"
  name_prefix         = local.name_prefix
  common_tags         = local.common_tags
  allowed_cidr_blocks = var.allowed_cidr_blocks
  vpc_id              = module.aws-vpc.vpc_id
}

resource "tls_private_key" "new_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "new-keypair" {
  key_name   = "${local.name_prefix}-${var.connector_name}-keypair"
  public_key = tls_private_key.new_key.public_key_openssh
  tags       = merge(local.common_tags, { Name = "${local.name_prefix}-keypair" })
}

module "aws-compute-win" {
  source            = "../../modules/aws-compute-win"
  allowlist_sg_id   = module.aws-allowlist_sg.allowlist_public_sg_id
  aws_region        = var.aws_region
  common_tags       = local.common_tags
  compute_name      = var.connector_name
  keypair_name      = aws_key_pair.new-keypair.key_name
  lab_pwd           = var.lab_pwd
  name_prefix       = local.name_prefix
  public_subnet_id  = module.aws-vpc.vpc_public_subnet_ids[0]
  vpc_cidr          = module.aws-vpc.vpc_cidr
  vpc_id            = module.aws-vpc.vpc_id
  compute_instance_type = "t3.xlarge"
}
module "aws-vpc" {
  source          = "../../modules/aws-vpc"
  aws_region      = var.aws_region
  name_prefix     = local.name_prefix
  common_tags     = local.common_tags
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
#  # enable nat gateway for lambda traffic if needed
#  enable_nat_gateway = false
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
  key_name   = "${local.name_prefix}-keypair"
  public_key = tls_private_key.new_key.public_key_openssh
  tags       = merge(local.common_tags, { Name = "${local.name_prefix}-keypair" })
}

data "aws_availability_zones" "available" {}

module "lab_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.2"

  cidr = var.vpc_cidr
  azs  = data.aws_availability_zones.available.names

  create_igw              = true
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-vpc"
  })

  manage_default_security_group  = true
  default_security_group_name    = "${var.name_prefix}-default-sg"
  default_security_group_egress  = []
  default_security_group_ingress = []
  default_security_group_tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-default-sg"
  })

  public_subnets     = var.public_subnets
  # Required for EKS (kubernetes.io/role/elb)
  public_subnet_tags = merge(var.common_tags, { "kubernetes.io/role/elb" = 1 })

  private_subnets     = var.private_subnets
  # Required for EKS (kubernetes.io/role/internal-elb)
  private_subnet_tags = merge(var.common_tags, { "kubernetes.io/role/internal-elb" = 1 })

}

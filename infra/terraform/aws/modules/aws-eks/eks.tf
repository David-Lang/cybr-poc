module "eks" {
  source = "terraform-aws-modules/eks/aws"

  # v18.30.3 is working with manage_aws_auth_configmap in combination with the K8s provider
  # Test aws_auth_users when updating versions
  # version = "18.30.3"
  version = "~> 20.31"

  # NAT Gateway expected on VPC
  #vpc_id     = var.vpc_id
  #subnet_ids = var.private_subnets

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_name                    = local.cluster_name
  cluster_version                 = "1.32" # (Released on January 23, 2025; standard support until March 23, 2026)
  cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_endpoint_private_access = true

  # must be accessible from where terraform is running from to establish manage_aws_auth_configmap
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = concat(var.allowed_cidr_blocks, [local.runner_ip_cidr])

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  tags                        = merge(var.common_tags, { Name = "${var.name_prefix}-eks" })
  cluster_security_group_tags = merge(var.common_tags, { Name = "${var.name_prefix}-eks-cluster-sg" })
  node_security_group_tags    = merge(var.common_tags, { Name = "${var.name_prefix}-eks-node-sg" })

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 40
    instance_types = ["t3a.small"]
    key_name       = aws_key_pair.eks_keypair.key_name
  }

  eks_managed_node_groups = {
    "${var.name_prefix}-eks-ng1" = {}
    "${var.name_prefix}-eks-ng2" = {
      min_size      = 1
      max_size      = 3
      desired_size  = 1
      capacity_type = "SPOT"
    }
  }

  cluster_security_group_additional_rules = {
    local-https = {
      type        = "ingress"
      description = "Local-HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    },
    local-https = {
      type        = "ingress"
      description = "Allowed-HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  node_security_group_additional_rules = {
    https-ingress = {
      type        = "ingress"
      description = "https ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  }

}

module "eks_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "~> 20.0"

  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = aws_iam_user.k8s_user.arn
      username = aws_iam_user.k8s_user.name
      groups   = ["system:masters"]
    }
  ]
}

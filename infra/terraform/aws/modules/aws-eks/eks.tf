module "eks" {
  source = "terraform-aws-modules/eks/aws"

  # v18.30.3 is working with manage_aws_auth_configmap in combination with the K8s provider
  # Test aws_auth_users when updating versions
  # version = "18.30.3"
  version = "~> 20.2"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_name                    = local.cluster_name
  cluster_version                 = "1.29"
  cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_endpoint_private_access = true

  # must be accessible from where terraform is running from to establish manage_aws_auth_configmap
  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = concat(var.allowed_cidr_blocks, [local.runner_ip_cidr])

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
    instance_types = ["t3.small"]
    key_name       = var.keypair_name
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
    mysql-egress = {
      type        = "egress"
      description = "mysql egress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    postgres-egress = {
      type        = "egress"
      description = "postgres egress"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    https-ingress = {
      type        = "ingress"
      description = "https ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  }

#  # aws-auth configmap
#  manage_aws_auth_configmap = true

#  aws_auth_users = [
#    {
#      userarn  = aws_iam_user.k8s_user.arn
#      username = aws_iam_user.k8s_user.name
#      groups   = ["system:masters"]
#    }
#  ]

#  aws_auth_roles = [
#    {
#      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/foo"
#      username = "sso-breakglass:{{SessionName}}"
#      groups   = ["sso-breakglass"]
#    },
#    {
#      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bar"
#      username = "sso-readall:{{SessionName}}"
#      groups   = ["sso-readall"]
#    },
#  ]

  cluster_security_group_tags = merge(var.common_tags, { Name = "${var.name_prefix}-eks-cluster-sg" })
  node_security_group_tags    = merge(var.common_tags, { Name = "${var.name_prefix}-eks-node-sg" })
  tags                        = merge(var.common_tags, { Name = "${var.name_prefix}-eks" })
}

#data "aws_caller_identity" "current" {}
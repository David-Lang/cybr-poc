locals {
  name_prefix = var.eks_name
  common_tags = merge(tomap(jsondecode(var.base_tags_json)), { Plan = var.plan_name })
}

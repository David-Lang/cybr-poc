locals {
  name_prefix = var.name_prefix
  common_tags = merge(tomap(jsondecode(var.base_tags_json)), { Plan = var.plan_name })
}

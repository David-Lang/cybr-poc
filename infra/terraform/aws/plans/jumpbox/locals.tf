locals {
  common_tags = merge(tomap(jsondecode(var.base_tags_json)), { Plan = var.plan_name })
}

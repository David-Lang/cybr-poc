locals {
  name_prefix         = var.isp_sub_domain
  compute_name_ubuntu = "${local.name_prefix}-ubuntu1"
  # 15 char max length for windows server names
  compute_name_win = "${local.name_prefix}-win1"
  #common_tags = merge(tomap(jsondecode(var.base_tags_json)), { Plan = var.plan_name })
}

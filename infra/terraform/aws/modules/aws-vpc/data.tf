data "template_file" "varset_create" {
  template = file("${path.module}/varset_create.tftpl.sh")
  vars = {
    name_prefix              = var.name_prefix
    terraform_cloud_api_key  = var.terraform_cloud_api_key
    terraform_cloud_org_name = var.terraform_cloud_org_name
    terraform_cloud_ws_id    = var.terraform_cloud_ws_id
    vpc_id                   = module.lab_vpc.vpc_id
    vpc_cidr                 = var.vpc_cidr
    vpc_private_subnet_ids   = join(",", module.lab_vpc.private_subnets)
    vpc_public_subnet_ids    = join(",", module.lab_vpc.public_subnets)
  }
}


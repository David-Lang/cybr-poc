data "template_file" "base_tfvars" {
  template = file("${path.module}/base.auto.tfvars.tmpl.out")
  vars = {
    aws_region              = var.aws_region
    base_tags_json          = replace(jsonencode(local.base_tags), "\"", "\\\"")
    isp_sub_domain          = var.isp_sub_domain
    keypair_name            = aws_key_pair.new-keypair.key_name
    name_prefix             = local.name_prefix
    private_key_openssh_b64 = base64encode(tls_private_key.new_key.private_key_openssh)
    public_key_openssh_b64  = base64encode(tls_private_key.new_key.public_key_openssh)
    vpc_allowlist_sg_id     = module.aws-allowlist_sg.allowlist_public_sg_id
    vpc_cidr                = local.vpc_cidr
    vpc_id                  = module.aws-vpc.vpc_id
    vpc_private_subnet_ids  = "[\"${join("\",\"", module.aws-vpc.vpc_private_subnet_ids)}\"]"
    vpc_public_subnet_ids   = "[\"${join("\",\"", module.aws-vpc.vpc_public_subnet_ids)}\"]"
  }
}

resource "local_file" "base_tfvars" {
  content         = data.template_file.base_tfvars.rendered
  filename        = "${path.module}/secrets.base.auto.tfvars.out"
  file_permission = "0444"
}


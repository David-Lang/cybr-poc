resource "local_file" "base_tfvars" {
  content         = data.template_file.base_tfvars.rendered
  filename        = "${path.module}/secrets.base.auto.tfvars.out"
  file_permission = "0444"
}


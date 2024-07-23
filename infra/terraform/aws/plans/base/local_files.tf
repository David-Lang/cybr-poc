resource "local_file" "base_auto_tfvars_out" {
  content         = data.template_file.tf_out_env.rendered
  filename        = "${path.module}/tf_out.env"
  file_permission = "0444"
}


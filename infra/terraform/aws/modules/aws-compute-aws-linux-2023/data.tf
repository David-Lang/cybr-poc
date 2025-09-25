data "template_file" "compute_user_data" {
  template = file("${path.module}/compute_user_data.tftpl.sh")
  vars = {
  }
}

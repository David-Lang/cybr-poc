resource "terraform_data" "varset_create_out" {
  provisioner "local-exec" {
    command     = "printf '%s\n' \"$script\" > varset_create.out && chmod +x varset_create.out && ./varset_create.out"
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.root
    environment = {
      script = data.template_file.varset_create.rendered
    }
  }
}

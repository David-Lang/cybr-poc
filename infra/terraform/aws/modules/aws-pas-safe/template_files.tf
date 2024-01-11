data "template_file" "isp_auth" {
  template = file("${path.module}/isp_auth.tftpl.json")
  vars = {
    client_id     = var.isp_client_id
    client_secret = var.isp_client_secret
  }
}

data "template_file" "pas_safe" {
  template = file("${path.module}/pas_safe.tftpl")
  vars = {
    safe_name     = var.safe_name
  }
}

data "template_file" "pas_safe_conjur_sync" {
  template = file("${path.module}/pas_safe_conjur_sync.tftpl")
  vars = {
    safe_name     = var.safe_name
  }
}
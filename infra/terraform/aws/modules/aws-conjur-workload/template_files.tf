data "template_file" "isp_auth" {
  template = file("${path.module}/isp_auth.tftpl.json")
  vars = {
    client_id     = var.isp_client_id
    client_secret = var.isp_client_secret
  }
}

data "template_file" "conjur_workload" {
  template = file("${path.module}/conjur_workload.tftpl.json")
  vars = {
    workload_name = var.workload_name,
    safe_name     = var.safe_name
  }
}
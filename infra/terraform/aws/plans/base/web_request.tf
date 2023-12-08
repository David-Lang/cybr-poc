data "http" "push_base_varset" {
  url    = "https://app.terraform.io/api/v2/organizations/${var.terraform_cloud_org_name}/varsets"
  method = "POST"

  request_headers = {
    Authorization = "Bearer ${var.terraform_cloud_api_key}"
    Content-Type  = "application/vnd.api+json"
  }

  request_body = data.template_file.varset_json.rendered
}

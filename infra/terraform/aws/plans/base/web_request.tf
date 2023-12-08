# The following example shows how to issue an HTTP POST request
# supplying an optional request body.
data "http" "push_base_varset" {
  url    = "https://app.terraform.io/api/v2/organizations/${var.terraform_cloud_org_name}/varsets"
  method = "POST"

  # Optional request headers
  request_headers = {
    Authorization = "Bearer ${var.terraform_cloud_api_key}"
    Content-Type  = "application/vnd.api+json"
  }

  # Optional request body
  request_body = data.template_file.varset_json.rendered
}

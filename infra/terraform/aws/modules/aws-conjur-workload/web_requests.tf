data "http" "isp_auth" {
  url    = "https://"
  method = "POST"

  request_headers = {
    Content-Type = "application/vnd.api+json"
  }

  request_body = data.template_file.isp_auth.rendered
}

# Safe must already exist
data "http" "conjur_workload" {
  url    = "https://"
  method = "POST"

  request_headers = {
    Authorization = "Bearer ${data.http.isp_auth.response_body}"
    Content-Type  = "application/vnd.api+json"
  }

  request_body = data.template_file.conjur_workload.rendered
}

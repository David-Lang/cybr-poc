data "http" "isp_auth" {
  url    = "https://"
  method = "POST"

  request_headers = {
    Content-Type = "application/vnd.api+json"
  }

  request_body = data.template_file.isp_auth.rendered
}

data "http" "pas_safe" {
  url    = "https://"
  method = "POST"

  request_headers = {
    Content-Type = "application/vnd.api+json"
  }

  request_body = data.template_file.pas_safe.rendered
}

# Safe must already exist
data "http" "pas_safe_conjur_sync" {
  url    = "https://"
  method = "POST"

  request_headers = {
    Authorization = "Bearer ${data.http.isp_auth.response_body}"
    Content-Type  = "application/vnd.api+json"
  }

  request_body = data.template_file.pas_safe_conjur_sync.rendered
}

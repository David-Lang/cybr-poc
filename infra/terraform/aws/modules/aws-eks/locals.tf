locals {
  cluster_name   = "${var.name_prefix}-eks"
  runner_ip_cidr = replace("${data.http.runner_ip.response_body}/32", "\n", "")
}

data "http" "runner_ip" {
  url = "https://checkip.amazonaws.com/"
}

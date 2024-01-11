output "workload_name" {
  value = var.workload_name
}

output "workload_api_key" {
  value = data.http.conjur_workload.response_body
}

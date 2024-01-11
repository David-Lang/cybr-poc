#------------------------------------------------------------------------------
# POC Conjur Settings
variable "poc_conjur_url" {
  type      = string
  sensitive = true
}
variable "poc_conjur_account" {
  type      = string
  sensitive = true
}
variable "poc_conjur_login" {
  type      = string
  sensitive = true
}
variable "poc_conjur_api_key" {
  type      = string
  sensitive = true
}
#------------------------------------------------------------------------------
# Conjur Workload Settings
variable "workload_name" { type = string }
variable "safe_name" { type = string }
#------------------------------------------------------------------------------
# ISP Settings
variable "isp_client_id" { type = string }
variable "isp_client_secret" { type = string }
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Conjur Settings
variable "conjur_url" {
  type      = string
  sensitive = true
}
variable "conjur_account" {
  type      = string
  sensitive = true
}
variable "conjur_login" {
  type      = string
  sensitive = true
}
variable "conjur_api_key" {
  type      = string
  sensitive = true
}
#------------------------------------------------------------------------------
# Conjur Secrets
variable "conjur_id_aws_access_key" {
  type      = string
  sensitive = true
}
variable "conjur_id_aws_secret_key" {
  type      = string
  sensitive = true
}
#
#------------------------------------------------------------------------------
# AWS Settings
variable "aws_region" { type = string }
#------------------------------------------------------------------------------
# Plan Settings
variable "owner" { type = string }
#------------------------------------------------------------------------------
# Terraform Cloud values
variable "terraform_cloud_api_key" { default = "false" }
variable "terraform_cloud_org_name" { default = "false" }
variable "terraform_cloud_ws_id" { type = string }
#------------------------------------------------------------------------------

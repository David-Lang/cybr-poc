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
#------------------------------------------------------------------------------
# AWS Settings
variable "aws_region" { type = string }
#------------------------------------------------------------------------------
# Plan Settings
variable "plan_name" { type = string }
variable "isp_sub_domain" { type = string }
variable "owner" { type = string }
#------------------------------------------------------------------------------
# Terraform Cloud values
variable "terraform_cloud_api_key" { type = string }
variable "terraform_cloud_org_name" { type = string }
variable "terraform_cloud_prj_id" { type = string }
#------------------------------------------------------------------------------
# Security Group Settings
variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to allow public access to. ex. ['2.3.4.5/32', '3.4.5.6/32']"
}
#------------------------------------------------------------------------------

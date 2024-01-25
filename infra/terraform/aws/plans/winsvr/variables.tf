# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
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
variable "lab_pwd" { type = string }
#------------------------------------------------------------------------------
# Compute Settings
variable "compute_name" { type = string }
#------------------------------------------------------------------------------
# Project Settings
variable "isp_sub_domain" { type = string }
variable "base_tags_json" { type = string }
variable "keypair_name" { type = string }
variable "public_key_openssh_b64" { type = string }
variable "vpc_id" { type = string }
variable "vpc_public_subnet_ids" { type = list(string) }
variable "vpc_cidr" { type = string }
variable "vpc_allowlist_sg_id" { type = string }
#------------------------------------------------------------------------------
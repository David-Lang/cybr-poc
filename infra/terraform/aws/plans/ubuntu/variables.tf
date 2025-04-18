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
variable "isp_sub_domain" { type = string }
variable "name_prefix" { type = string }

#------------------------------------------------------------------------------
# Project Settings
variable "base_tags_json" { type = string }
variable "keypair_name" { type = string }
variable "vpc_id" { type = string }
variable "vpc_public_subnet_ids" { type = list(string) }
variable "vpc_cidr" { type = string }
variable "vpc_allowlist_sg_id" { type = string }
#------------------------------------------------------------------------------
# Compute Settings
variable "compute_name" { type = string }
#------------------------------------------------------------------------------

# Terraform loads variables in the following order,
# with later sources taking precedence over earlier ones:
#
# Environment variables
# The terraform.tfvars file, if present.
# The terraform.tfvars.json file, if present.
# Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
# Any -var and -var-file options on the command line, in the order they are provided.
# (This includes variables set by a Terraform Cloud workspace.)

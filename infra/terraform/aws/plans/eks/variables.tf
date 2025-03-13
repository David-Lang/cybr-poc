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
#------------------------------------------------------------------------------
# Project Settings
variable "base_tags_json" { type = string }
variable "keypair_name" { type = string }
variable "vpc_id" { type = string }
variable "vpc_private_subnet_ids" { type = list(string) }
variable "vpc_public_subnet_ids" { type = list(string) }
variable "vpc_cidr" { type = string }
#------------------------------------------------------------------------------
# EKS Settings
#------------------------------------------------------------------------------
variable "eks_name" { type = string }
# Security Group Settings
variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to allow public access to. ex. ['2.3.4.5/32', '3.4.5.6/32']"
}
variable "allowed_cidr_blocks_kubectl" {
  type = list(string)
  # this allows to add additional IPs to the allowed cidr that are just specific to K8s api
  # default to empty list to allow for this to be an optional param
  default     = []
  description = "CIDR blocks to allow public access to. ex. ['2.3.4.5/32', '3.4.5.6/32']"
}
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

# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Conjur Settings
#variable "conjur_url" {
#  type      = string
#  sensitive = true
#}
#variable "conjur_account" {
#  type      = string
#  sensitive = true
#}
#variable "conjur_login" {
#  type      = string
#  sensitive = true
#}
#variable "conjur_api_key" {
#  type      = string
#  sensitive = true
#}
#------------------------------------------------------------------------------
# Conjur Secrets
#variable "conjur_id_aws_access_key" {
#  type      = string
#  sensitive = true
#}
#variable "conjur_id_aws_secret_key" {
#  type      = string
#  sensitive = true
#}

variable "client_id" {
  type        = string
  description = "The Client ID for the Azure Service Principal."
}

variable "client_secret" {
  type        = string
  description = "The Client Secret for the Azure Service Principal."
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "The Tenant ID for the Azure Service Principal."
}

variable "subscription_id" {
  type        = string
  description = "The Subscription ID for the Azure Service Principal."
}

variable "object_id" {
  type        = string
  description = "The Object ID for the user to provide default access to AKVs."
}

##------------------------------------------------------------------------------
## Azure Settings
variable "az_region" { type = string }
##------------------------------------------------------------------------------
## Plan Settings
variable "plan_name" { type = string }
variable "isp_sub_domain" { type = string }
##------------------------------------------------------------------------------
## Project Settings
#variable "base_tags_json" { type = string }
#variable "keypair_name" { type = string }
#variable "vpc_id" { type = string }
#variable "vpc_public_subnet_ids" { type = list(string) }
#variable "vpc_cidr" { type = string }
#variable "vpc_allowlist_sg_id" { type = string }
#------------------------------------------------------------------------------
# Compute Settings
#variable "compute_name" { type = string }
variable "compute_user" { type = string }
variable "compute_pwd" { type = string }
#------------------------------------------------------------------------------
# Allowed IPs
variable "allow_ip" { type = string }
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

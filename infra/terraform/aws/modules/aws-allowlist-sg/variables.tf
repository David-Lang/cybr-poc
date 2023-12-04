# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
#
variable "common_tags" { type = map(string) }
variable "name_prefix" { type = string }
#------------------------------------------------------------------------------
#
variable "vpc_id" {
  type        = string
  description = "Id of VPC to use"
}
variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to allow public access to. ex. ['10.10.10.11/32', '10.10.10.12/32']"
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

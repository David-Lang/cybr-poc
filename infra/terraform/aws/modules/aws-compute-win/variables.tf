# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
#
variable "aws_region" { type = string }
variable "common_tags" { type = map(string) }
variable "name_prefix" { type = string }
#------------------------------------------------------------------------------
#
variable "keypair_name" { type = string }
#------------------------------------------------------------------------------
#
variable "compute_name" { type = string }
variable "compute_instance_type" { type = string }
variable "lab_pwd" { type = string }
#------------------------------------------------------------------------------
#
variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }
variable "vpc_cidr" { type = string }
variable "allowlist_sg_id" { type = string }
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

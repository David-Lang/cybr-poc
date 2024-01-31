# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
#
variable "aws_region" { type = string }

variable "common_tags" { type = map(string) }
variable "name_prefix" { type = string }
variable "plan_name" { type = string }

variable "vpc_id" {
  type        = string
  description = "Id of VPC to use"
}

variable "vpc_cidr" { type = string }

variable "private_subnets" {
  type        = list(string)
  description = "subnets to use for EKS"
}

variable "keypair_name" { type = string }

#------------------------------------------------------------------------------
# Security Group Settings
variable "allowed_cidr_blocks" {
  type        = list(string)
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
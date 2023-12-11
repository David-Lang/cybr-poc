# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
#
variable "aws_region" { type = string }
#------------------------------------------------------------------------------
#
variable "path_to_public_key" {
  type        = string
  description = "Path to key to use with EC2s"
  sensitive   = true
}
#------------------------------------------------------------------------------
# Labeling
variable "common_tags" { type = map(string) }
variable "name_prefix" { type = string }

#------------------------------------------------------------------------------

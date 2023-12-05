# This file is to define the variables values should be set in .tfvars or other
#------------------------------------------------------------------------------
# AWS Settings
variable "aws_region" { type = string }
#------------------------------------------------------------------------------
# Labeling
variable "common_tags" { type = map(string) }
variable "name_prefix" { type = string }
variable "plan_name" { type = string }
#------------------------------------------------------------------------------
# Network CIDR values
resource "random_integer" "octet" {
  min = 50
  max = 250
}
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { default = ["10.0.10.0/24"] }
variable "private_subnets" { default = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"] }
#------------------------------------------------------------------------------
# Network Options
variable "enable_nat_gateway" { default = "false" }
#------------------------------------------------------------------------------
# Terraform Cloud values
variable "terraform_cloud_api_key" { type = string }
variable "terraform_cloud_org_name" { type = string }
variable "terraform_cloud_ws_id" { type = string }
#------------------------------------------------------------------------------

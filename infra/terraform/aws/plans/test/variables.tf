#------------------------------------------------------------------------------
# Conjur Settings
variable "conjur_url" {
  type = string
  sensitive   = true
}
variable "conjur_account" {
  type = string
  sensitive   = true
}
variable "conjur_login" {
  type = string
  sensitive   = true
}
variable "conjur_api_key" {
  type = string
  sensitive   = true
}
#------------------------------------------------------------------------------
# AWS Settings
variable "aws_region" { type = string }
#------------------------------------------------------------------------------

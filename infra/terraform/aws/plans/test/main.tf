variable "db_password" {
  type = string
  default = "HelloPassword"
}

data "aws_caller_identity" "current" {}

data "conjur_secret" "aws_access_key" {
  name = "data/vault/cybr-poc/cybr-poc-se-amer-aws/AWSAccessKeyID"
}

data "conjur_secret" "aws_secret_key" {
  name = "data/vault/cybr-poc/cybr-poc-se-amer-aws/password"
}

# data.conjur_secret.db_password.value will be set by the Conjur Provider
output "db_password_output" {
  value = var.db_password
  sensitive = true
}

output "aws_identity_arn" {
  value = data.aws_caller_identity.current.arn
  sensitive = false
}
data "aws_caller_identity" "current" {}

data "conjur_secret" "aws_access_key" {
  name = "data/vault/cybr-poc-terraform/cybr-poc-se-amer-aws/AWSAccessKeyID"
}

data "conjur_secret" "aws_secret_key" {
  name = "data/vault/cybr-poc-terraform/cybr-poc-se-amer-aws/password"
}

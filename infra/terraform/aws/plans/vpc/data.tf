data "aws_caller_identity" "current" {}

data "conjur_secret" "aws_access_key" {
  name = var.conjur_id_aws_access_key
}

data "conjur_secret" "aws_secret_key" {
  name = var.conjur_id_aws_secret_key
}

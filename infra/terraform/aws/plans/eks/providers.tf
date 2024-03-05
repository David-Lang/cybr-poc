terraform {
  required_providers {
    conjur = {
      source  = "cyberark/conjur"
      version = "0.6.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "conjur" {
  appliance_url = var.conjur_url
  account       = var.conjur_account
  login         = var.conjur_login
  api_key       = var.conjur_api_key
}

data "conjur_secret" "aws_access_key" {
  name = var.conjur_id_aws_access_key
}

data "conjur_secret" "aws_secret_key" {
  name = var.conjur_id_aws_secret_key
}

//noinspection HILUnresolvedReference
provider "aws" {
  region     = var.aws_region
  access_key = data.conjur_secret.aws_access_key.value
  secret_key = data.conjur_secret.aws_secret_key.value
}

# Configuration for the AWS Provider can be derived from several sources,
# which are applied in the following order:
#
# Parameters in the provider configuration
# Environment variables
# Shared credentials files
# Shared configuration files
# Container credentials
# Instance profile credentials and region
#
# This order matches the precedence used by the AWS CLI and the AWS SDKs.
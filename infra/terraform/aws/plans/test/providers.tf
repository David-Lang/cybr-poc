terraform {
  required_providers {
    conjur = {
      source = "cyberark/conjur"
      version = "0.6.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "conjur" {
  appliance_url = var.conjur_url
  account = var.conjur_account
  login = var.conjur_login
  api_key = var.conjur_api_key
}
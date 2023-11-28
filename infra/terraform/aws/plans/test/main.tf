variable "db_password" {
  type = string
  default = "HelloPassword"
}

# data.conjur_secret.db_password.value will be set by the Conjur Provider
output "db_password_output" {
  value = var.db_password
  sensitive = true
}

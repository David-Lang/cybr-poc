output "aws_identity_arn" {
  value     = data.aws_caller_identity.current.arn
  sensitive = false
}

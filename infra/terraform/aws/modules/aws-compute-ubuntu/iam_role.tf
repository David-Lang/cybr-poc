resource "aws_iam_role" "iam_authn_role" {
  name = "${var.name_prefix}-${var.compute_name}-iam_authn_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}-iam_authn_role" })
}

resource "aws_iam_instance_profile" "iam_authn_profile" {
  name = "${var.name_prefix}-${var.compute_name}-iam_authn_profile-${var.compute_name}"
  role = aws_iam_role.iam_authn_role.name
  tags = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}-iam_authn_profile" })
}

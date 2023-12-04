resource "aws_security_group" "allowlist_public_sg" {
  vpc_id = var.vpc_id
  name   = "${var.name_prefix}-allowlist-public-sg"

  ingress {
    description = "allowlist_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "allowlist_https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "allowlist_rdp"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  tags = merge(var.common_tags, { Name = "${var.name_prefix}-allowlist-public-sg" })
}

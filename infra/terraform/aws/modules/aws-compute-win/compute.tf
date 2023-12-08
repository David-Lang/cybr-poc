resource "aws_instance" "compute" {
  ami                    = data.aws_ami.win_server.id
  instance_type          = var.compute_instance_type
  key_name               = var.keypair_name
  user_data              = data.template_file.userdata.rendered
  vpc_security_group_ids = [aws_security_group.compute_win_sg.id, var.allowlist_sg_id]
  subnet_id              = var.public_subnet_id
  tags                   = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}" })
}

resource "aws_eip" "compute" {
  instance = aws_instance.compute.id
  vpc      = true
  tags     = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}" })
}

resource "aws_security_group" "compute_win_sg" {
  vpc_id = var.vpc_id
  name   = "${var.name_prefix}-${var.compute_name}-sg"

  ingress {
    description = "VPC_SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}-sg" })
}

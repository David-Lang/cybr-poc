resource "aws_instance" "compute_vm" {
  instance_type               = var.compute_instance_type
  ami                         = data.aws_ami.amazon_linux_2023.id
  key_name                    = var.keypair_name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jumpbox_sg.id, var.allowlist_sg_id]
  iam_instance_profile        = aws_iam_instance_profile.iam_authn_profile.name
  tags                        = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}" })
  user_data                   = data.template_file.compute_user_data.rendered
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
  }
}

resource "aws_eip" "compute_vm" {
  instance = aws_instance.compute_vm.id
  domain   = "vpc"
  tags     = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}" })
}

resource "aws_security_group" "jumpbox_sg" {
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
    description = "LOCAL_HTTP"
    from_port   = 8080
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.name_prefix}-${var.compute_name}-sg" })
}

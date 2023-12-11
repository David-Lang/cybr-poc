resource "aws_key_pair" "lab-keypair" {
  key_name   = "${var.name_prefix}-keypair"
  public_key = file(var.path_to_public_key)
  tags       = merge(var.common_tags, { Name = "${var.name_prefix}-keypair" })
}

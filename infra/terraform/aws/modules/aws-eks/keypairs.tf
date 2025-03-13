# Generate a new SSH key pair
resource "tls_private_key" "eks_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "eks_keypair" {
  key_name   = "${module.eks.cluster_name}-keypair"
  public_key = tls_private_key.eks_keypair.public_key_openssh

  tags = {
    Name = "${module.eks.cluster_name}-keypair"
  }
}

# Save the private key locally
resource "local_file" "eks_private_key" {
  filename        = "${path.module}/my-eks-keypair.pem"
  content         = tls_private_key.eks_keypair.private_key_pem
  file_permission = "0600"
}


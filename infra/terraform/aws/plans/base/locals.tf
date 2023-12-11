locals {
  name_prefix = var.isp_sub_domain

  //noinspection HILUnresolvedReference
  vpc_cidr        = "10.${random_integer.random_octet.result}.0.0/16"
  public_subnets  = ["10.${random_integer.random_octet.result}.10.0/24"]
  private_subnets = ["10.${random_integer.random_octet.result}.20.0/24"]

  # Common tags to be assigned to all resources
  base_tags = {
    Owner     = var.owner
    Purpose   = "cybr-poc"
    Terraform = "true"
    Workspace = terraform.workspace
    CreatedBy = data.aws_caller_identity.current.arn
    # To prevent installing the SSM Agent
    CA_iSSMExclude = "YES"
    # To prevent installing the Trend Micro Agent
    CA_iTMExclude       = "YES"
    CA_iTMExcludeReason = "POV Test"
    # To prevent stopped instance auto deletion
    CA_iEC2Retain = "active"
  }

  common_tags = merge(local.base_tags, { Plan = var.plan_name })
}

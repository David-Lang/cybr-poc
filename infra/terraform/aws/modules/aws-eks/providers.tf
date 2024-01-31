/*
The following 2 data resources are used get around the fact that we have to wait
for the EKS cluster to be initialised before we can attempt to authenticate.
*/

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

#data "aws_eks_cluster" "this" {
#  name = local.cluster_name
#  depends_on = [
#    module.eks.eks_managed_node_groups,
#  ]
#}
#
#data "aws_eks_cluster_auth" "this" {
#  name = local.cluster_name
#  depends_on = [
#    module.eks.eks_managed_node_groups,
#  ]
#}
#
#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.this.endpoint
#  token                  = data.aws_eks_cluster_auth.this.token
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
#}
#

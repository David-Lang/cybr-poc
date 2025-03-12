output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "k8s_user_name" {
  description = "K8s User Name"
  value       = aws_iam_user.k8s_user.name
}

output "k8s_user_access_key" {
  description = "K8s User Access Key"
  value       = aws_iam_access_key.k8s_user.id
}

output "k8s_user_secret" {
  description = "K8s User Secret"
  value       = aws_iam_access_key.k8s_user.secret
}

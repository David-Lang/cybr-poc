output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.lab-aws-eks.cluster_name
}

output "k8s_user_name" {
  description = "K8s User Name"
  value       = module.lab-aws-eks.k8s_user_name
}

output "k8s_user_access_key" {
  description = "K8s User Access Key"
  value       = module.lab-aws-eks.k8s_user_access_key
}

output "k8s_user_secret" {
  description = "K8s User Secret"
  value       = module.lab-aws-eks.k8s_user_secret
  sensitive   = true
}

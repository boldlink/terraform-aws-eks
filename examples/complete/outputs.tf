output "cluster_version" {
  value       = module.complete_eks_cluster.cluster_version
  description = "The kubernetes version of the cluster"
}

output "platform_version" {
  value       = module.complete_eks_cluster.platform_version
  description = "Platform version for this cluster"
}

# Cluster
output "arn" {
  value       = aws_eks_cluster.main.arn
  description = "ARN of the cluster."
}

output "certificate_authority" {
  value       = aws_eks_cluster.main.certificate_authority
  description = "Attribute block containing `certificate-authority-data` for your cluster"
}

output "created_at" {
  value       = aws_eks_cluster.main.created_at
  description = "Unix epoch timestamp in seconds for when the cluster was created."
}

output "endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "Endpoint for your Kubernetes API server."
}

output "id" {
  value       = aws_eks_cluster.main.id
  description = "Name of the cluster."
}

output "identity" {
  value       = aws_eks_cluster.main.identity
  description = "Attribute block containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019."
}

output "platform_version" {
  value       = aws_eks_cluster.main.platform_version
  description = "Platform version for the cluster."
}

output "status" {
  value       = aws_eks_cluster.main.status
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`."
}

output "tags_all" {
  value       = aws_eks_cluster.main.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block)."
}

output "vpc_config" {
  value       = aws_eks_cluster.main.vpc_config
  description = "Configuration block argument that also includes attributes for the VPC associated with your cluster."
}


#eks addon
output "eks_addon_arn" {
  value = [
    for addon in aws_eks_addon.main : addon.arn
  ]
  description = "Amazon Resource Name (ARN) of the EKS add-on."
}

output "eks_addon_id" {
  value = [
    for addon in aws_eks_addon.main : addon.id
  ]
  description = "EKS Cluster name and EKS Addon name separated by a colon (`:`)."
}

output "eks_addon_status" {
  value = [
    for addon in aws_eks_addon.main : addon.status
  ]
  description = "Status of the EKS add-on(s)."
}

output "eks_addon_created_at" {
  value = [
    for addon in aws_eks_addon.main : addon.created_at
  ]
  description = "Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was created."
}

output "eks_addon_modified_at" {
  value = [
    for addon in aws_eks_addon.main : addon.modified_at
  ]
  description = "Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was updated."
}

output "eks_addon_tags_all" {
  value = [
    for addon in aws_eks_addon.main : addon.tags_all
  ]
  description = "(Optional) Key-value map of resource tags, including those inherited from the provider [default_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

#aws_eks_identity_provider_config
output "eks_identity_provider_config_arn" {
  value = [
    for provider in aws_eks_identity_provider_config.main : provider.arn
  ]
  description = "Amazon Resource Name (ARN) of the EKS Identity Provider Configuration."
}

output "eks_identity_provider_config_id" {
  value = [
    for provider in aws_eks_identity_provider_config.main : provider.id
  ]
  description = "EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (`:`)."
}

output "eks_identity_provider_config_status" {
  value = [
    for provider in aws_eks_identity_provider_config.main : provider.status
  ]
  description = "Status of the EKS Identity Provider Configuration."
}

output "eks_identity_provider_config_tags_all" {
  value = [
    for provider in aws_eks_identity_provider_config.main : provider.tags_all
  ]
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.7472759.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

# IAM Roles
output "managed_role_arn" {
  description = "The name of the node group IAM role"
  value       = [for node in module.node_group : node.role_arn]
}

output "managed_role_name" {
  description = "ARN of the node group IAM role"
  value       = [for node in module.node_group : node.role_name]
}

output "fargate_role_arn" {
  description = "The name of the node group IAM role"
  value = [
    for node in module.fargate_profile : node.role_arn
  ]
}

output "fargate_role_name" {
  description = "ARN of the node group IAM role"
  value = [
    for node in module.fargate_profile : node.role_name
  ]
}

output "oidc_arn" {
  description = "The name of the node group IAM role"
  value       = [for provider in aws_iam_openid_connect_provider.irsa : provider.arn]
}

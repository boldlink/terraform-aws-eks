/*
eks cluster
*/

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

/*
eks addon
*/

output "eks_addon_arn" {
  value       = aws_eks_addon.main.*.arn
  description = "Amazon Resource Name (ARN) of the EKS add-on."
}

output "eks_addon_id" {
  value       = aws_eks_addon.main.*.id
  description = "EKS Cluster name and EKS Addon name separated by a colon (`:`)."
}

output "eks_addon_status" {
  value       = aws_eks_addon.main.*.status
  description = "Status of the EKS add-on."
}

output "eks_addon_created_at" {
  value       = aws_eks_addon.main.*.created_at
  description = "Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was created."
}

output "eks_addon_modified_at" {
  value       = aws_eks_addon.main.*.modified_at
  description = "Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was updated."
}

output "eks_addon_tags_all" {
  value       = aws_eks_addon.main.*.tags_all
  description = "(Optional) Key-value map of resource tags, including those inherited from the provider [default_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

/*
eks node group
*/

output "eks_node_group_arn" {
  value       = aws_eks_node_group.main.*.arn
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
}

output "eks_node_group_id" {
  value       = aws_eks_node_group.main.*.id
  description = "EKS Cluster name and EKS Node Group name separated by a colon (`:`)."
}

output "eks_node_group_resources" {
  value       = aws_eks_node_group.main.*.resources
  description = "List of objects containing information about underlying resources."
}

output "eks_node_group_tags_all" {
  value       = aws_eks_node_group.main.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.50114275.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

output "eks_node_group_status" {
  value       = aws_eks_node_group.main.*.status
  description = "Status of the EKS Node Group."
}

/*
eks fargate profile
*/

output "fargate_profile_arn" {
  value       = aws_eks_fargate_profile.main.*.arn
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
}

output "fargate_profile_id" {
  value       = aws_eks_fargate_profile.main.*.id
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
}

output "fargate_profile_status" {
  value       = aws_eks_fargate_profile.main.*.status
  description = "Status of the EKS Fargate Profile."
}

output "fargate_profile_tags_all" {
  value       = aws_eks_fargate_profile.main.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.247767490.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

/*
aws_eks_identity_provider_config: Manages an EKS Identity Provider Configuration.
*/

output "eks_identity_provider_config_arn" {
  value       = aws_eks_identity_provider_config.main.*.arn
  description = "Amazon Resource Name (ARN) of the EKS Identity Provider Configuration."
}

output "eks_identity_provider_config_id" {
  value       = aws_eks_identity_provider_config.main.*.id
  description = "EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (`:`)."
}

output "eks_identity_provider_config_status" {
  value       = aws_eks_identity_provider_config.main.*.status
  description = "Status of the EKS Identity Provider Configuration."
}

output "eks_identity_provider_config_tags_all" {
  value       = aws_eks_identity_provider_config.main.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.7472759.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

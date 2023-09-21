
# node group
output "eks_node_group_arn" {
  value       = aws_eks_node_group.main[*].arn
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
}

output "eks_node_group_id" {
  value       = aws_eks_node_group.main[*].id
  description = "EKS Cluster name and EKS Node Group name separated by a colon (`:`)."
}

output "eks_node_group_resources" {
  value       = aws_eks_node_group.main[*].resources
  description = "List of objects containing information about underlying resources."
}

output "eks_node_group_tags_all" {
  value       = aws_eks_node_group.main[*].tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.50114275.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

output "eks_node_group_status" {
  value       = aws_eks_node_group.main[*].status
  description = "Status of the EKS Node Group."
}

# Managed IAM Roles
output "role_name" {
  description = "The name of the node group IAM role"
  value       = aws_iam_role.node_group[*].name
}

output "role_arn" {
  description = "ARN of the node group IAM role"
  value       = aws_iam_role.node_group[*].arn
}

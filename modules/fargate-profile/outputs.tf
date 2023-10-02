
# fargate profile
output "fargate_profile_arn" {
  value       = aws_eks_fargate_profile.main[*].arn
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
}

output "fargate_profile_id" {
  value       = aws_eks_fargate_profile.main[*].id
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
}

output "fargate_profile_status" {
  value       = aws_eks_fargate_profile.main[*].status
  description = "Status of the EKS Fargate Profile."
}

output "fargate_profile_tags_all" {
  value       = aws_eks_fargate_profile.main[*].tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.247767490.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block)."
}

# IAM Roles
output "role_name" {
  description = "The name of the node group IAM role"
  value       = aws_iam_role.fargate_profile[*].name
}

output "role_arn" {
  description = "ARN of the node group IAM role"
  value       = aws_iam_role.fargate_profile[*].arn
}

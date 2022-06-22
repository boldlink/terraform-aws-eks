output "outputs" {
  description = "Example cluster output"
  value = [
    module.fargate_profile,
    module.eks_vpc
  ]
}

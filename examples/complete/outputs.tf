output "outputs" {
  description = "Example cluster output"
  value = [
    module.complete_eks_cluster,
    module.eks_vpc
  ]
}

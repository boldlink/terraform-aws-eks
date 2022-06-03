locals {
  cidr_block         = "10.0.0.0/16"
  tag_env            = "dev"
  cluster_name       = "example-minimum-cluster"
  eks_public_subnet1 = cidrsubnet(local.cidr_block, 8, 60)
  eks_public_subnet2 = cidrsubnet(local.cidr_block, 8, 65)
  eks_public_subnet3 = cidrsubnet(local.cidr_block, 8, 70)
  eks_public_subnets = [local.eks_public_subnet1, local.eks_public_subnet2, local.eks_public_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
}

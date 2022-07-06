
locals {
  cidr_block          = "10.1.0.0/16"
  tag_env             = "dev"
  cluster_name        = "example-complete-cluster"
  eks_public_subnets  = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  eks_private_subnets = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
  az1                 = data.aws_availability_zones.available.names[0]
  az2                 = data.aws_availability_zones.available.names[1]
  az3                 = data.aws_availability_zones.available.names[2]
  azs                 = [local.az1, local.az2, local.az3]
}

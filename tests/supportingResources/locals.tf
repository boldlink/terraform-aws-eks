locals {
  public_subnets      = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  eks_public_subnets  = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
  private_subnets     = [cidrsubnet(local.cidr_block, 8, 7), cidrsubnet(local.cidr_block, 8, 8), cidrsubnet(local.cidr_block, 8, 9)]
  eks_private_subnets = [cidrsubnet(local.cidr_block, 8, 10), cidrsubnet(local.cidr_block, 8, 11), cidrsubnet(local.cidr_block, 8, 12)]
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.id
  dns_suffix          = data.aws_partition.current.dns_suffix
  partition           = data.aws_partition.current.partition
  azs                 = flatten(data.aws_availability_zones.available.names)
  cidr_block          = "192.169.0.0/16"
  name                = "terraform-aws-eks"
  tags = {
    environment        = "examples"
    name               = local.name
    "user::CostCenter" = "terraform-registry"
  }
  cluster_name = "example-complete-eks"
}

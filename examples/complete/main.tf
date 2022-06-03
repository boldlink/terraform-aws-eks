
module "eks_vpc" {
  source               = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  name                 = "${local.cluster_name}-vpc"
  account              = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.name
  cluster_name         = local.cluster_name
  tag_env              = local.tag_env
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  ## EKS Subnets
  eks_public_subnets      = local.eks_public_subnets
  availability_zones      = local.azs
  map_public_ip_on_launch = true
}

module "complete_eks_cluster" {
  source                    = "./../../"
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_name              = local.cluster_name
  cluster_subnet_ids        = flatten(module.eks_vpc.public_eks_subnet_id)
  vpc_id                    = module.eks_vpc.id
  node_groups = {
    managed = {
      create       = true
      subnet_ids   = flatten(module.eks_vpc.public_eks_subnet_id)
      disk_size    = 30
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }
}

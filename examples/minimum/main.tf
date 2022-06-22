
module "minimum_eks_cluster" {
  source                    = "./../../"
  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  cluster_name              = local.cluster_name
  cluster_subnet_ids        = flatten(module.eks_vpc.public_eks_subnet_id)
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}

module "eks_vpc" {
  source             = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  name               = "${local.cluster_name}-vpc"
  cluster_name       = local.cluster_name
  account            = data.aws_caller_identity.current.account_id
  region             = data.aws_region.current.name
  tag_env            = local.tag_env
  cidr_block         = local.cidr_block
  eks_public_subnets = local.eks_public_subnets
  availability_zones = local.azs
}

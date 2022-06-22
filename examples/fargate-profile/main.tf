
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

  ## Fargate Subnets
  private_subnets    = local.fargate_private_subnets
  availability_zones = local.azs
}

module "fargate_profile" {
  source                    = "./../../"
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_name              = local.cluster_name
  cluster_subnet_ids        = flatten(module.eks_vpc.private_subnet_id)
  vpc_id                    = module.eks_vpc.id
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
  fargate_profiles = {
    default = {
      create               = true
      fargate_profile_name = "${local.cluster_name}-default"
      subnet_ids           = flatten(module.eks_vpc.private_subnet_id)
      selector = [
        {
          namespace = "default"
          labels = {
            "app.kubernetes.io/name" = "app"
          }
        }
      ]
      tags = {
        environment        = "examples"
        "user::CostCenter" = "terraform-registry"
      }
    }
  }
}

module "kms_key" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = var.description
  create_kms_alias = var.create_kms_alias
  alias_name       = "alias/${var.name}"
  kms_policy       = local.kms_policy
  tags             = merge({ "Name" = var.name }, var.tags)
}

module "eks_vpc" {
  source                 = "boldlink/vpc/aws"
  version                = "3.0.4"
  name                   = var.name
  cidr_block             = var.cidr_block
  enable_dns_hostnames   = true
  enable_public_subnets  = true
  enable_private_subnets = true
  tags                   = var.tags
  public_subnets = {
    public = {
      cidrs                   = local.public_subnets
      map_public_ip_on_launch = true
      nat                     = "single"
    },
    eks = {
      cidrs = local.eks_public_subnets
      tags = {
        "kubernetes.io/cluster/example-complete-eks" = "shared"
        "kubernetes.io/cluster/example-minimum-eks"  = "shared"
        "kubernetes.io/role/elb"                     = true
      }
    }
  }

  private_subnets = {
    private = {
      cidrs = local.private_subnets
    },
    eks = {
      cidrs = local.eks_private_subnets
      tags = {
        "kubernetes.io/cluster/example-complete-eks" = "shared"
        "kubernetes.io/cluster/example-minimum-eks"  = "shared"
        "kubernetes.io/role/internal-elb"            = true
      }
    }
  }
}

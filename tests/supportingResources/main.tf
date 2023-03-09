module "kms_key" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = "kms key for ${var.name} nodule secrets"
  create_kms_alias = true
  alias_name       = "alias/${var.name}"
  kms_policy       = local.kms_policy
  tags             = merge({ "Name" = var.name }, var.tags)
}

module "eks_vpc" {
  source                  = "boldlink/vpc/aws"
  version                 = "2.0.3"
  name                    = var.name
  account                 = local.account_id
  region                  = local.region
  cidr_block              = var.cidr_block
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  create_nat_gateway      = var.create_nat_gateway
  nat_single_az           = var.nat_single_az
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  eks_public_subnets      = local.eks_public_subnets
  eks_private_subnets     = local.eks_private_subnets
  cluster_name            = var.cluster_name
  availability_zones      = local.azs
  map_public_ip_on_launch = var.map_public_ip_on_launch
  other_tags              = var.tags
}

module "kms_key" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = "kms key for ${local.name} nodule secrets"
  create_kms_alias = true
  alias_name       = "alias/${local.name}"
  kms_policy       = data.aws_iam_policy_document.kms_policy.json
  tags             = local.tags
}

module "eks_vpc" {
  source                  = "boldlink/vpc/aws"
  version                 = "2.0.3"
  name                    = local.name
  account                 = local.account_id
  region                  = local.region
  cidr_block              = local.cidr_block
  enable_dns_hostnames    = true
  create_nat_gateway      = true
  nat_single_az           = true
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  eks_public_subnets      = local.eks_public_subnets
  eks_private_subnets     = local.eks_private_subnets
  cluster_name            = local.cluster_name
  availability_zones      = local.azs
  map_public_ip_on_launch = true

  tags = local.tags
}


module "minimum_eks_cluster" {
  source                    = "./../../"
  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  cluster_name              = local.cluster_name
  vpc_id                    = local.vpc_id
  cluster_subnet_ids        = local.public_subnets
  tags                      = local.tags
  create_eks_kms_key         = true
}

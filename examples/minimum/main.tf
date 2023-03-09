module "minimum_eks_cluster" {
  source                    = "./../../"
  enabled_cluster_log_types = var.enabled_cluster_log_types
  cluster_name              = var.cluster_name
  vpc_id                    = local.vpc_id
  cluster_subnet_ids        = local.public_subnets
  tags                      = local.tags
  #create_eks_kms_key        = true
}

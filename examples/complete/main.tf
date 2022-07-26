module "complete_eks_cluster" {
  source                     = "./../../"
  cluster_name               = local.cluster_name
  cluster_subnet_ids         = local.public_subnets
  vpc_id                     = local.vpc_id
  enable_irsa                = true
  enable_managed_node_groups = true
  enable_fargate_node_groups = true
  enabled_cluster_log_types  = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  endpoint_private_access    = false
  endpoint_public_access     = true
  cloudwatch_key_id          = local.kms_key_arn
  encryption_config = {
    key_arn = local.kms_key_arn
  }
  managed_node_groups = {
    managed0 = {
      create       = true
      subnet_ids   = local.public_subnets
      disk_size    = 30
      desired_size = 2
      max_size     = 3
      min_size     = 1
      tags         = local.tags
    }
    managed1 = {
      create        = true
      subnet_ids    = local.public_subnets
      capacity_type = "SPOT"
      tags          = local.tags
    }
  }
  fargate_node_groups = {
    fargate0 = {
      selector = [
        {
          namespace = "app1"
          labels = {
            "app.kubernetes.io/type" = "fargate0"
          }
        }
      ]
      subnet_ids = local.private_subnets
      tags       = local.tags
    }
    fargate1 = {
      selector = [
        {
          namespace = "app2"
          labels = {
            "app.kubernetes.io/type" = "fargate1"
          }
        }
      ]
      subnet_ids = local.private_subnets
      tags       = local.tags
    }
  }
  tags = local.tags
}

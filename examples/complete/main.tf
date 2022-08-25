
data "aws_eks_cluster" "default" {
  name = module.complete_eks_cluster.id
}

data "aws_eks_cluster_auth" "default" {
  name = module.complete_eks_cluster.id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

module "complete_eks_cluster" {
  source                     = "./../../"
  cluster_name               = local.cluster_name
  cluster_subnet_ids         = local.public_subnets
  vpc_id                     = local.vpc_id
  enable_irsa                = true
  enable_managed_node_groups = true
  enable_fargate_node_groups = true
  modify_aws_auth            = true
  enabled_cluster_log_types  = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  endpoint_private_access    = false
  endpoint_public_access     = true
  cloudwatch_key_id          = local.kms_key_arn
  encryption_config = {
    key_arn = local.kms_key_arn
  }
  aws_auth_node_iam_role_arns = flatten(concat(module.complete_eks_cluster.managed_role_arn,module.complete_eks_cluster.fargate_role_arn))

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::12345678901:role/examplerole"
      username = "examplerole"
      groups   = ["system:masters"]
    },
  ]
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

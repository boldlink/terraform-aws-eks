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
  #checkov:skip=CKV_AWS_38: "Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0"
  #checkov:skip=CKV_AWS_39: "Ensure Amazon EKS public endpoint disabled"
  source                     = "./../../"
  cluster_name               = var.cluster_name
  cluster_subnet_ids         = local.public_subnets
  vpc_id                     = local.vpc_id
  enable_irsa                = var.enable_irsa
  enable_managed_node_groups = var.enable_managed_node_groups
  enable_fargate_node_groups = var.enable_fargate_node_groups
  modify_aws_auth            = var.modify_aws_auth
  enabled_cluster_log_types  = var.enabled_cluster_log_types
  kms_key_arn                = local.kms_key_arn
  endpoint_public_access     = var.endpoint_public_access
  endpoint_private_access    = var.endpoint_private_access

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/complete-eks-example-role"
      username = "examplerole"
      groups   = ["system:masters"]
    },
  ]
  managed_node_groups = {
    managed0 = {
      create       = true
      subnet_ids   = local.private_subnets
      disk_size    = 30
      desired_size = 3
      max_size     = 3
      min_size     = 1
      tags         = local.tags
    }
    managed1 = {
      create        = true
      subnet_ids    = local.private_subnets
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

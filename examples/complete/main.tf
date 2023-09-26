resource "aws_security_group" "external" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  name                   = "${var.cluster_name}-managed-node-sg"
  description            = "Allow eks cluster-lc inbound traffic"
  vpc_id                 = local.vpc_id
  tags                   = merge({ Name = "${var.cluster_name}-managed-node-sg" }, var.tags)
  revoke_rules_on_delete = true

  ingress {
    description = "Allow cluster traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "3m"
  }
}

module "ebs_kms" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = "AWS CMK for encrypting eks ebs volumes"
  create_kms_alias = true
  kms_policy       = local.kms_policy
  alias_name       = "alias/${var.cluster_name}-key-alias"
  tags             = var.tags
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
      desired_size = 3
      max_size     = 3
      min_size     = 1
      tags         = local.tags

      # launch template
      create_custom_launch_template = true
      launch_template_description   = "EKS managed node group launch template"
      ebs_optimized                 = true
      install_ssm_agent             = true
      security_group_ids            = [aws_security_group.external.id]
      block_device_mappings = [
        {
          # Root volume
          device_name = "/dev/xvda"
          no_device   = 0
          ebs = {
            delete_on_termination = true
            volume_size           = 30
            volume_type           = "gp3"
            encrypted             = true
            kms_key_arn           = module.ebs_kms.arn
          }
        },
        {
          device_name = "/dev/sda1"
          no_device   = 1
          ebs = {
            delete_on_termination = true
            volume_size           = 30
            volume_type           = "gp2"
            encrypted             = true
            kms_key_arn           = module.ebs_kms.arn
          }
        }
      ]

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      tag_specifications = [
        {
          resource_type = "volume"
          tags          = local.tags
        },
        {
          resource_type = "instance"
          tags          = local.tags
        }
      ]

    }
    managed1 = {
      create        = true
      subnet_ids    = local.private_subnets
      capacity_type = "SPOT"
      taints = {
        dedicated = {
          "key"    = "dedicated"
          "value"  = "true"
          "effect" = "NO_SCHEDULE"
        }
        example1 = {
          "key"    = "example1"
          "value"  = "true"
          "effect" = "NO_EXECUTE"
        }
        example1 = {
          "key"    = "example2"
          "value"  = "true"
          "effect" = "PREFER_NO_SCHEDULE"
        }
      }
      tags = local.tags
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

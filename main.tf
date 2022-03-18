/*
eks cluster
*/

resource "aws_eks_cluster" "main" {
  name                      = var.name
  role_arn                  = var.role_arn
  enabled_cluster_log_types = var.enabled_cluster_log_types
  tags                      = var.tags
  version                   = var.kubernetes_master_version
  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = var.security_group_ids
    subnet_ids              = var.cluster_subnet_ids
  }

  dynamic "kubernetes_network_config" {
    for_each = var.kubernetes_network_config
    content {
      service_ipv4_cidr = lookup(kubernetes_network_config.value, "service_ipv4_cidr", null)
      ip_family         = lookup(kubernetes_network_config.value, "ip_family", null)
    }
  }


  dynamic "encryption_config" {
    for_each = var.encryption_config
    content {
      dynamic "provider" {
        for_each = lookup(encryption_config.value, "provider")
        content {
          key_arn = provider.value.key_arn
        }
      }
      resources = encryption_config.value.resources
    }
  }
}

/*
eks addon
*/

resource "aws_eks_addon" "main" {
  count                    = var.create_eks_addon ? 1 : 0
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = var.addon_name
  addon_version            = var.addon_version
  resolve_conflicts        = var.resolve_conflicts
  tags                     = var.tags
  service_account_role_arn = var.service_account_role_arn
}

/*
eks node group
*/

resource "aws_eks_node_group" "main" {
  count                  = var.create_eks_node_group ? 1 : 0
  cluster_name           = aws_eks_cluster.main.name
  node_role_arn          = var.node_role_arn
  subnet_ids             = var.node_group_subnet_ids
  ami_type               = var.ami_type
  capacity_type          = var.capacity_type
  disk_size              = var.disk_size
  force_update_version   = var.force_update_version
  instance_types         = var.instance_types
  labels                 = var.labels
  node_group_name        = var.node_group_name_prefix != null ? null : var.node_group_name
  node_group_name_prefix = var.node_group_name != null ? null : var.node_group_name_prefix
  release_version        = var.release_version
  tags                   = var.tags
  version                = var.kubernetes_version

  dynamic "scaling_config" {
    for_each = var.scaling_config
    content {
      desired_size = scaling_config.value.desired_size
      max_size     = scaling_config.value.max_size
      min_size     = scaling_config.value.min_size
    }
  }

  dynamic "update_config" {
    for_each = var.update_config
    content {
      max_unavailable            = lookup(update_config.value, "max_unavailable", null)
      max_unavailable_percentage = lookup(update_config.value, "max_unavailable_percentage", null)
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      #use ONLY EITHER `id` or `name`
      id      = lookup(launch_template.value, "id", null)
      name    = lookup(launch_template.value, "name", null)
      version = launch_template.value.version
    }
  }

  dynamic "remote_access" {
    for_each = var.remote_access
    content {
      ec2_ssh_key               = lookup(remote_access.value, "ec2_ssh_key", null)
      source_security_group_ids = lookup(remote_access.value, "source_security_group_ids", [])
    }
  }

  dynamic "taint" {
    for_each = var.taint
    content {
      key    = taint.value.key
      value  = lookup(taint.value, "value", null)
      effect = taint.value.effect
    }
  }

  timeouts {
    create = lookup(var.timeouts, "create", "60m")
    update = lookup(var.timeouts, "update", "60m")
    delete = lookup(var.timeouts, "delete", "60m")
  }
}

/*
eks fargate profile
*/

resource "aws_eks_fargate_profile" "main" {
  count                  = var.create_eks_fargate_profile ? 1 : 0
  cluster_name           = aws_eks_cluster.main.name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = var.pod_execution_role_arn
  subnet_ids             = var.fargate_profile_subnet_ids
  tags                   = var.tags

  dynamic "selector" {
    for_each = var.selector
    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", {})
    }
  }
}

/*
aws_eks_identity_provider_config: Manages an EKS Identity Provider Configuration.
*/

resource "aws_eks_identity_provider_config" "main" {
  count        = var.create_eks_identity_provider_config ? 1 : 0
  cluster_name = aws_eks_cluster.main.name
  tags         = var.tags

  dynamic "oidc" {
    for_each = var.oidc
    content {
      client_id                     = oidc.value.client_id
      groups_claim                  = lookup(oidc.value, "groups_claim", null)
      groups_prefix                 = lookup(oidc.value, "groups_prefix", null)
      identity_provider_config_name = oidc.value.identity_provider_config_name
      issuer_url                    = oidc.value.issuer_url
      required_claims               = lookup(oidc.value, "required_claims", null)
      username_claim                = lookup(oidc.value, "username_claim", null)
      username_prefix               = lookup(oidc.value, "username_prefix", null)
    }
  }

  timeouts {
    create = lookup(var.timeouts, "create", "40m")
    delete = lookup(var.timeouts, "delete", "40m")
  }
}

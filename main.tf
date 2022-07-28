/*
Eks cluster
*/
resource "aws_eks_cluster" "main" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.ekscluster.arn
  enabled_cluster_log_types = var.enabled_cluster_log_types
  tags                      = var.tags
  version                   = var.kubernetes_master_version
  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = concat(compact([(join(aws_security_group.eks_cluster.id, var.security_group_ids))]))
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
    for_each = [var.encryption_config]
    content {
      provider {
        key_arn = try(encryption_config.value.key_arn, aws_kms_key.secrets_kms_key[0].arn)
      }
      resources = ["secrets"]
    }
  }

  /*
  Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  */
  depends_on = [
    aws_iam_role_policy_attachment.amazoneksclusterpolicy,
    aws_iam_role_policy_attachment.amazoneksvpccontroller,
    aws_cloudwatch_log_group.main
  ]
}

resource "aws_kms_key" "secrets_kms_key" {
  count                   = length(keys(var.encryption_config)) == 0 ? 1 : 0
  description             = "A kms key for eks cluster secrets"
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = local.kms_policy
  enable_key_rotation     = var.enable_key_rotation
  tags                    = var.tags
}

resource "aws_kms_alias" "secrets_kms_key" {
  count         = length(keys(var.encryption_config)) == 0 ? 1 : 0
  name          = "alias/${var.cluster_name}-secrets"
  target_key_id = aws_kms_key.secrets_kms_key[0].key_id
}

resource "aws_iam_role" "ekscluster" {
  name               = "${var.cluster_name}-main"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json
}

resource "aws_iam_role_policy_attachment" "amazoneksclusterpolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.ekscluster.name
}

/*
Optionally, enable Security Groups for Pods
Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
*/
resource "aws_iam_role_policy_attachment" "amazoneksvpccontroller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.ekscluster.name
}

/*
Control Plane Logging
*/
resource "aws_kms_key" "logging_kms_key" {
  count                   = var.enable_cp_logging && var.cloudwatch_key_id == null ? 1 : 0
  description             = "A kms key for eks cluster cloudwatch log group"
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = local.kms_policy
  enable_key_rotation     = var.enable_key_rotation
  tags                    = var.tags
}

resource "aws_kms_alias" "logging_kms_key" {
  count         = var.enable_cp_logging && var.cloudwatch_key_id == null ? 1 : 0
  name          = "alias/${var.cluster_name}-cloudwatch-key"
  target_key_id = aws_kms_key.logging_kms_key[0].key_id
}


resource "aws_cloudwatch_log_group" "main" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  count             = var.enable_cp_logging ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_group_retention_days
  kms_key_id        = var.cloudwatch_key_id != null ? var.cloudwatch_key_id : aws_kms_key.logging_kms_key[0].arn
}

/*
Eks addon
*/
resource "aws_eks_addon" "main" {
  for_each                 = var.eks_addons
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = lookup(each.value, "addon_name", null)
  addon_version            = lookup(each.value, "addon_version", null)
  resolve_conflicts        = lookup(each.value, "resolve_conflicts", null)
  tags                     = lookup(each.value, "tags", null)
  service_account_role_arn = lookup(each.value, "service_account_role_arn", null)

  lifecycle {
    ignore_changes = [
      modified_at
    ]
  }
}

/*
Enable cluster IRSA
*/
data "tls_certificate" "irsa" {
  count = var.enable_irsa ? 1 : 0
  url   = "https://oidc.eks.${local.region}.${local.dns_suffix}"
}

resource "aws_iam_openid_connect_provider" "irsa" {
  count           = var.enable_irsa ? 1 : 0
  client_id_list  = ["sts.${local.dns_suffix}"]
  thumbprint_list = [data.tls_certificate.irsa[0].certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.main.identity[0].oidc[0].issuer
  tags = merge(
    { Name = "${var.cluster_name}-eks-irsa" },
    var.tags
  )
  depends_on = [
    aws_eks_cluster.main
  ]
}

/*
aws_eks_identity_provider_config: Manages an EKS Identity Provider Configuration.
*/
resource "aws_eks_identity_provider_config" "main" {
  for_each     = var.identity_providers
  cluster_name = aws_eks_cluster.main.name
  oidc {
    client_id                     = each.value.client_id
    groups_claim                  = lookup(each.value, "groups_claim", null)
    groups_prefix                 = lookup(each.value, "groups_prefix", null)
    identity_provider_config_name = try(each.value.identity_provider_config_name, each.key)
    issuer_url                    = each.value.issuer_url
    required_claims               = lookup(each.value, "required_claims", null)
    username_claim                = lookup(each.value, "username_claim", null)
    username_prefix               = lookup(each.value, "username_prefix", null)
  }
  tags = var.tags
  timeouts {
    create = lookup(var.timeouts, "create", "40m")
    delete = lookup(var.timeouts, "delete", "40m")
  }
}

/*
aws-auth configmap
*/
resource "kubernetes_config_map" "aws_auth" {
  count = var.include_aws_auth_configmap ? 1 : 0
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = local.aws_auth_configmap_data
  lifecycle {
    ignore_changes = [data]
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  count = var.include_aws_auth_configmap ? 1 : 0
  force = true
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = local.aws_auth_configmap_data
  depends_on = [
    kubernetes_config_map.aws_auth,
  ]
}

/*
Security group
*/
resource "aws_security_group" "eks_cluster" {
  name        = "${var.cluster_name}-security-group"
  vpc_id      = var.vpc_id
  description = "EKS cluster Security Group"
  tags        = var.tags
}

resource "aws_security_group_rule" "ingress" {
  for_each          = var.ingress_rules
  type              = "ingress"
  description       = "Allow custom inbound traffic from specific ports."
  from_port         = lookup(each.value, "from_port")
  to_port           = lookup(each.value, "to_port")
  protocol          = lookup(each.value, "to_port")
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  security_group_id = aws_security_group.eks_cluster.id
}

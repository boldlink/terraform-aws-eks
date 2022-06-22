
resource "aws_eks_fargate_profile" "main" {
  count                  = var.create_fargate_profile ? 1 : 0
  cluster_name           = var.cluster_name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.fargate_profile.arn
  subnet_ids             = var.fargate_profile_subnet_ids
  tags                   = var.tags

  dynamic "selector" {
    for_each = var.selector
    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", {})
    }
  }

  dynamic "timeouts" {
    for_each = [var.timeouts]
    content {
      create = lookup(var.timeouts, "create", "10m")
      delete = lookup(var.timeouts, "delete", "10m")
    }
  }
}

resource "aws_iam_role" "fargate_profile" {
  name = "${var.cluster_name}-fargate-profile-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "pod_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_profile.name
}


resource "aws_eks_fargate_profile" "main" {
  for_each               = var.fargate_profiles
  cluster_name           = var.cluster_name
  fargate_profile_name   = try(each.value.name, each.key)
  pod_execution_role_arn = lookup(each.value, "pod_execution_role_arn", null)
  subnet_ids             = lookup(each.value, "subnet_ids", null)
  tags                   = lookup(each.value, "tags", {})

  dynamic "selector" {
    for_each = try([each.value.selector], [])
    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", {})
    }
  }
}

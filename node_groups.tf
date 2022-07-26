module "node_group" {
  for_each               = { for k, v in var.managed_node_groups : k => v if var.enable_managed_node_groups == true }
  source                 = "./modules/managed-node-group"
  cluster_name           = aws_eks_cluster.main.name
  create_key_pair        = lookup(each.value, "create_key_pair", false)
  desired_size           = lookup(each.value, "desired_size", 1)
  max_size               = lookup(each.value, "max_size", 3)
  min_size               = lookup(each.value, "min_size", 1)
  update_config          = lookup(each.value, "update_config", {})
  node_group_subnet_ids  = lookup(each.value, "subnet_ids")
  ami_type               = lookup(each.value, "ami_type", null)
  capacity_type          = lookup(each.value, "capacity_type", "ON_DEMAND")
  disk_size              = lookup(each.value, "disk_size", null)
  force_update_version   = lookup(each.value, "force_update_version", false)
  instance_types         = lookup(each.value, "instance_types", ["t3.medium"])
  labels                 = lookup(each.value, "labels", {})
  launch_template        = lookup(each.value, "launch_template", {})
  node_group_name        = try(each.value.name, each.key)
  node_group_name_prefix = lookup(each.value, "node_group_name_prefix", null)
  release_version        = lookup(each.value, "release_version", null)
  remote_access          = lookup(each.value, "remote_access", {})
  tags                   = lookup(each.value, "tags", {})
  taint                  = lookup(each.value, "taint", {})
  kubernetes_version     = lookup(each.value, "kubernetes_version", null)
  timeouts               = lookup(each.value, "timeouts", {})
}

module "fargate_profile" {
  for_each                   = { for k, v in var.fargate_node_groups : k => v if var.enable_fargate_node_groups == true }
  source                     = "./modules/fargate-profile"
  cluster_name               = aws_eks_cluster.main.name
  fargate_profile_name       = try(each.value.fargate_profile_name, each.key)
  fargate_profile_subnet_ids = lookup(each.value, "subnet_ids")
  tags                       = lookup(each.value, "tags", {})
  selector                   = try(each.value.selector, [])
  timeouts                   = lookup(each.value, "timeouts", {})
}

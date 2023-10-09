module "node_group" {
  for_each               = { for k, v in var.managed_node_groups : k => v if var.enable_managed_node_groups == true }
  source                 = "./modules/managed-node-group"
  cluster_name           = aws_eks_cluster.main.name
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
  node_group_name        = try(each.value.name, each.key)
  node_group_name_prefix = lookup(each.value, "node_group_name_prefix", null)
  release_version        = lookup(each.value, "release_version", null)
  tags                   = lookup(each.value, "tags", {})
  taints                 = try(each.value.taints, {})
  kubernetes_version     = lookup(each.value, "kubernetes_version", null)
  timeouts               = lookup(each.value, "timeouts", {})

  # launch_template
  create_custom_launch_template      = lookup(each.value, "create_custom_launch_template", false)
  install_ssm_agent                  = lookup(each.value, "install_ssm_agent", true)
  launch_template_id                 = lookup(each.value, "launch_template_id", null)
  launch_template_version            = lookup(each.value, "launch_template_version", null)
  enable_monitoring                  = lookup(each.value, "enable_monitoring", false)
  launch_template_description        = lookup(each.value, "launch_template_description", null)
  security_group_ids                 = lookup(each.value, "security_group_ids", [])
  ebs_optimized                      = lookup(each.value, "ebs_optimized", false)
  image_id                           = lookup(each.value, "image_id", null)
  instance_type                      = lookup(each.value, "instance_type", null)
  user_data                          = lookup(each.value, "user_data", null)
  default_version                    = lookup(each.value, "default_version", null)
  disable_api_termination            = lookup(each.value, "disable_api_termination", false)
  kernel_id                          = lookup(each.value, "kernel_id", null)
  ram_disk_id                        = lookup(each.value, "ram_disk_id", null)
  block_device_mappings              = lookup(each.value, "block_device_mappings", [])
  capacity_reservation_specification = lookup(each.value, "capacity_reservation_specification", {})
  cpu_options                        = lookup(each.value, "cpu_options", {})
  cpu_credits                        = lookup(each.value, "cpu_credits", null)
  elastic_gpu_specifications         = lookup(each.value, "elastic_gpu_specifications", {})
  enclave_options                    = lookup(each.value, "enclave_options", {})
  license_specifications             = lookup(each.value, "license_specifications", {})
  metadata_options                   = lookup(each.value, "metadata_options", {})
  network_interfaces                 = lookup(each.value, "network_interfaces", [])
  placement                          = lookup(each.value, "placement", {})
  private_dns_name_options           = lookup(each.value, "private_dns_name_options", {})
  tag_specifications                 = lookup(each.value, "tag_specifications", [])
  extra_script                       = lookup(each.value, "extra_script", "")
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

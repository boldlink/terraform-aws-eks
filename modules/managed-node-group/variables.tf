variable "cluster_name" {
  type        = string
  description = "Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
}

variable "desired_size" {
  description = "(Required) Desired number of worker nodes."
  type        = number
  default     = 1
}
variable "max_size" {
  description = "(Required) Maximum number of worker nodes, recommend multiples of 3."
  type        = number
  default     = 3
}
variable "min_size" {
  description = "(Required) Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "update_config" {
  type        = map(string)
  description = "(Optional) Desired max number/max percentage of unavailable worker nodes during node group update."
  default     = {}
}

variable "node_group_subnet_ids" {
  type        = list(string)
  description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME` (where `CLUSTER_NAME` is replaced with the name of the EKS Cluster)."
}

variable "ami_type" {
  type        = string
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  default     = "BOTTLEROCKET_x86_64"
}

variable "capacity_type" {
  type        = string
  description = "(Optional) Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`."
  default     = "ON_DEMAND"
}

variable "disk_size" {
  type        = number
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20."
  default     = null
}

variable "force_update_version" {
  type        = bool
  description = "(Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  default     = false
}

variable "instance_types" {
  type        = list(string)
  description = "(Optional) List of instance types associated with the EKS Node Group. Defaults to `[t3.medium]`."
  default     = ["t3.medium"]
}

variable "labels" {
  type        = map(string)
  description = "(Optional) Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed."
  default     = {}
}

variable "node_group_name" {
  type        = string
  description = "(Optional) Name of the EKS Node Group. If omitted, Terraform will assign a random, unique name. Conflicts with `node_group_name_prefix`."
  default     = null
}

variable "node_group_name_prefix" {
  type        = string
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with `node_group_name`."
  default     = null
}

variable "release_version" {
  type        = string
  description = "(Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
  default     = null
}

variable "taints" {
  type        = any
  description = "(Optional) The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group."
  default     = {}
}

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  default     = null
}

variable "timeouts" {
  type        = map(string)
  description = "Configuration specifying how long to wait for the EKS Node Group to be created, updated and deleted"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://www.terraform.io../docs?_ga=2.83681619.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

## Launch template
variable "create_custom_launch_template" {
  type        = bool
  description = "Specify whether to create custom launch template"
  default     = false
}

variable "install_ssm_agent" {
  type        = bool
  description = "Whether to install ssm agent"
  default     = false
}

variable "user_data" {
  type        = string
  description = "The base64-encoded user data to provide when launching the instance."
  default     = null
}

variable "launch_template_id" {
  type        = string
  description = "The ID of external launch template to use"
  default     = null
}

variable "launch_template_version" {
  type        = string
  description = "The version of the launch template"
  default     = null
}

variable "enable_monitoring" {
  type        = bool
  description = "Choose whether to enable monitoring"
  default     = false
}

variable "launch_template_description" {
  type        = string
  description = "(Optional) Description of the launch template."
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate."
  default     = []
}

variable "ebs_optimized" {
  type        = bool
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  default     = false
}

variable "image_id" {
  type        = string
  description = "(Optional) The AMI from which to launch the instance."
  default     = null
}

variable "instance_type" {
  type        = string
  description = "(Optional) The type of the instance."
  default     = null
}

variable "default_version" {
  type        = number
  description = "(Optional) Default Version of the launch template."
  default     = null
}

variable "disable_api_termination" {
  type        = bool
  description = "(Optional) If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "kernel_id" {
  type        = string
  description = "(Optional) The kernel ID."
  default     = null
}

variable "ram_disk_id" {
  type        = string
  description = "(Optional) The ID of the RAM disk."
  default     = null
}

variable "block_device_mappings" {
  type        = list(any)
  description = "The storage device mapping block"
  default     = []
}

variable "capacity_reservation_specification" {
  type        = map(string)
  description = "(Optional) Targeting for EC2 capacity reservations."
  default     = {}
}

variable "cpu_options" {
  type        = map(string)
  description = "(Optional) The CPU options for the instance."
  default     = {}
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = null
}

variable "elastic_gpu_specifications" {
  type        = map(string)
  description = "(Optional) The elastic GPU to attach to the instance."
  default     = {}
}

variable "enclave_options" {
  type        = map(string)
  description = "(Optional) Enable Nitro Enclaves on launched instances."
  default     = {}
}

variable "instance_market_options" {
  type        = map(string)
  description = "(Optional) The market (purchasing) option for the instance."
  default     = {}
}

variable "license_specifications" {
  type        = map(string)
  description = "(Optional) A list of license specifications to associate with."
  default     = {}
}

variable "metadata_options" {
  type        = map(string)
  description = "(Optional) Customize the metadata options for the instance."
  default     = {}
}

variable "network_interfaces" {
  type        = any
  description = "(Optional) Customize network interfaces to be attached at instance boot time."
  default     = []
}

variable "placement" {
  type        = map(string)
  description = "(Optional) The placement of the instance."
  default     = {}
}

variable "private_dns_name_options" {
  type        = map(string)
  description = "(Optional) The options for the instance hostname. The default values are inherited from the subnet."
  default     = {}
}

variable "tag_specifications" {
  type        = list(any)
  description = "The tags to apply to the resources during launch."
  default     = ["instance", "volume"]
}

variable "extra_script" {
  type        = string
  description = "The name of the extra script"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
  default     = null
}

variable "create_eks_managed_node_group" {
  type        = bool
  description = "Specify whether to create node group or not"
  default     = false
}

variable "desired_size" {
  description = "(Required) Desired number of worker nodes."
  type        = number
  default     = 1
}
variable "max_size" {
  description = "(Required) Maximum number of worker nodes."
  type        = number
  default     = 4
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
  default     = []
}

variable "ami_type" {
  type        = string
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  default     = null
}

variable "capacity_type" {
  type        = string
  description = "(Optional) Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`."
  default     = null
}

variable "disk_size" {
  type        = number
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
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

variable "launch_template" {
  type        = map(string)
  description = "(Optional) Configuration block with Launch Template settings."
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

variable "remote_access" {
  type        = map(string)
  description = "(Optional) Configuration block with remote access settings."
  default     = {}
}

variable "taint" {
  type        = map(string)
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

# Key Pair
variable "create_key_pair" {
  description = "Whether or not to create a key pair"
  type        = bool
  default     = true
}

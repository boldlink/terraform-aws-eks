variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "complete-eks-example"
}

variable "supporting_resources_name" {
  type        = string
  description = "The name of the supporting resources stack"
  default     = "terraform-aws-eks"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the eks resources"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    InstanceScheduler  = true
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}

variable "enable_irsa" {
  description = "Enable Open Identity connect support for AWS IAM Roles"
  type        = bool
  default     = true
}

variable "enable_managed_node_groups" {
  description = "Set this variable to true to create your managed node groups"
  type        = bool
  default     = true
}

variable "enable_fargate_node_groups" {
  description = "Set this variable to true to create your fargate node groups"
  type        = bool
  default     = true
}

variable "modify_aws_auth" {
  description = "Choose whether to manage the aws-auth configmap"
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of the desired control plane logging to enable."
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the Amazon EKS private API server endpoint is enabled. Default is `false`."
  default     = false
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether the Amazon EKS public API server endpoint is enabled. Default is `true`."
  default     = true
}

variable "capacity_reservation_preference" {
  description = "Indicates the instance's Capacity Reservation preferences. Can be 'open' or 'none'. (Default: 'open')"
  type        = string
  default     = "open"
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "unlimited"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "example-complete-eks"
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

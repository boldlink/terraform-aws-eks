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

variable "aws_auth_roles" {
  type        = any
  description = "List of IAM role ARNs to add to the aws-auth configmap"
  default = {
    rolearn  = "arn:aws:iam::12345678901:role/examplerole"
    username = "examplerole"
    groups   = ["system:masters"]
  }
}

variable "enable_irsa" {
  type        = bool
  description = "Enable Open Identity connect support for AWS IAM Roles"
  default     = true
}

variable "enable_managed_node_groups" {
  type        = bool
  description = "Set this variable to true to create your managed node groups"
  default     = true
}

variable "enable_fargate_node_groups" {
  type        = bool
  default     = true
  description = "Whether to fargate node groups"
}

variable "modify_aws_auth" {
  type        = bool
  description = "Choose whether to manage the aws-auth configmap"
  default     = true
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of the desired control plane logging to enable."
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the Amazon EKS private API server endpoint is enabled."
  default     = false
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether the Amazon EKS public API server endpoint is enabled. Default is `true`."
  default     = true
}

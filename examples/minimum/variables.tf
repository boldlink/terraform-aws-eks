variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "minimum-eks-example"
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

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of the desired control plane logging to enable."
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

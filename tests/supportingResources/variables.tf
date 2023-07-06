variable "name" {
  type        = string
  description = "Name of the stack"
  default     = "terraform-aws-eks"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "192.169.0.0/16"
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

variable "create_kms_alias" {
  type        = bool
  description = "Whether to create CMK kms alias"
  default     = true
}

variable "description" {
  type        = string
  description = "Description for the CMK kms key"
  default     = "kms key for eks module secrets"
}

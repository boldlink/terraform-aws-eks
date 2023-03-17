variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "example-complete-eks"
}

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

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults `false`."
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support"
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to map public IP to instances launched on the public subnets"
  default     = true
}

variable "nat_single_az" {
  type        = bool
  description = "Whether to create a single NAT"
  default     = true
}

variable "create_nat_gateway" {
  type        = bool
  description = "Whether to create any NAT Gateway"
  default     = true
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

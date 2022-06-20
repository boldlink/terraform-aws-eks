
variable "create_fargate_profile" {
  description = "Whether to create eks fargate profile"
  type        = bool
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
  default     = null
}

variable "fargate_profile_name" {
  description = "(Required) Name of the EKS Fargate Profile."
  type        = string
}

variable "fargate_profile_subnet_ids" {
  description = "(Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

variable "selector" {
  description = "(Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile."
  type        = any
  default     = []
}

variable "timeouts" {
  description = "Fargate profile timeout configuration"
  type        = map(string)
  default     = {}
}

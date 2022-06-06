# eks cluster
variable "cluster_name" {
  type        = string
  description = "Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
  default     = null
}

variable "aws_auth_node_iam_role_arns" {
  description = "List of node IAM role ARNs to add to the aws-auth configmap"
  type        = list(string)
  default     = []
}

variable "aws_auth_roles" {
  description = "List of IAM role ARNs to add to the aws-auth configmap"
  type        = list(string)
  default     = []
}

variable "include_aws_auth_configmap" {
  description = "Choose whether to include the aws-auth configmap"
  type        = bool
  default     = false
}

variable "eks_addons" {
  type        = any
  description = "EKS Addons resource block"
  default     = {}
}
# Cloudwatch
variable "enable_cp_logging" {
  type        = bool
  description = "Determine whether to enable control plane logging"
  default     = true
}

variable "log_group_retention_days" {
  type        = number
  description = "Number of days the log group is retained before it is deleted"
  default     = 7
}

variable "cloudwatch_key_id" {
  description = " (Optional) The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
  default     = null
}

variable "aws_auth_accounts" {
  description = "List of account maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "aws_auth_users" {
  description = "List of user maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "endpoint_private_access" {
  type        = bool
  description = "(Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is `false`."
  default     = true
}

variable "endpoint_public_access" {
  type        = bool
  description = "(Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is `true`."
  default     = false
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "(Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration."
  default     = ["0.0.0.0/0"]
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
  default     = []
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "(Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "(Optional) List of the desired control plane logging to enable."
  default     = []
}

variable "encryption_config" {
  type        = map(string)
  description = "(Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020."
  default     = {}
}

variable "kubernetes_network_config" {
  type        = map(string)
  description = "(Optional) Configuration block with kubernetes network configuration for the cluster."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://www.terraform.io../docs?_ga=2.83681619.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "kubernetes_master_version" {
  type        = string
  description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  default     = null
}

# Identity provider
variable "identity_providers" {
  type        = any
  description = "Identity providers resources block"
  default     = {}
}

variable "timeouts" {
  type        = map(string)
  description = "Configuration specifying how long to wait for the EKS Node Group to be created, updated and deleted"
  default     = {}
}

# Security Group
variable "vpc_id" {
  description = "(Optional, Forces new resource) VPC ID"
  type        = string
  default     = null
}

variable "ingress_rules" {
  description = "(Optional) Ingress rules to add to the security group"
  type        = any
  default     = {}
}

variable "node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

# KMS
variable "deletion_window_in_days" {
  description = "(Optional) The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30."
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "(Optional) Specifies whether key rotation is enabled. Defaults to false."
  type        = bool
  default     = true
}

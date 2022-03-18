/*
#eks cluster
*/

variable "name" {
  type        = string
  description = "(Required) Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
}

variable "role_arn" {
  type        = string
  description = "(Required) ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. Ensure the resource configuration includes explicit dependencies on the IAM Role permissions by adding depends_on if using the aws_iam_role_policy resource or aws_iam_role_policy_attachment resource, otherwise EKS cannot delete EKS managed EC2 infrastructure such as Security Groups on EKS Cluster deletion."
}

variable "endpoint_private_access" {
  type        = bool
  description = "(Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is `false`."
  default     = false
}

variable "endpoint_public_access" {
  type        = bool
  description = "(Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is `true`."
  default     = true
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

/*
eks addon
*/

variable "create_eks_addon" {
  type        = bool
  description = "choose whether to create eks addon"
  default     = false
}

variable "addon_name" {
  type        = string
  description = "(Required) Name of the EKS add-on."
  default     = ""
}

variable "addon_version" {
  type        = string
  description = "(Optional) The version of the EKS add-on. The version must match one of the versions returned by [describe-addon-versions](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html)."
  default     = null
}

variable "resolve_conflicts" {
  type        = string
  description = "(Optional) Define how to resolve parameter value conflicts when migrating an existing add-on to an Amazon EKS add-on or when applying version updates to the add-on. Valid values are `NONE` and `OVERWRITE`."
  default     = null
}

variable "service_account_role_arn" {
  type        = string
  description = "(Optional) The Amazon Resource Name (ARN) of an existing IAM role to bind to the add-on's service account. The role must be assigned the IAM permissions required by the add-on. If you don't specify an existing IAM role, then the add-on uses the permissions assigned to the node IAM role."
  default     = null
}

/*
eks node group
*/

variable "create_eks_node_group" {
  type        = bool
  description = "Specify whether to create node group or not"
  default     = false
}

variable "node_role_arn" {
  type        = string
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
  default     = ""
}

variable "scaling_config" {
  type        = map(string)
  description = "(Required) Configuration block with scaling settings."
  default     = {}
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

/*
eks fargate profile
*/

variable "create_eks_fargate_profile" {
  type        = bool
  description = "Specify whether to create this resource or not"
  default     = false
}

variable "fargate_profile_name" {
  type        = string
  description = "(Required) Name of the EKS Fargate Profile."
  default     = ""
}

variable "pod_execution_role_arn" {
  type        = string
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile."
  default     = ""
}

variable "selector" {
  type        = map(string)
  description = "(Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile."
  default     = {}
}

variable "fargate_profile_subnet_ids" {
  type        = list(string)
  description = "(Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME` (where `CLUSTER_NAME` is replaced with the name of the EKS Cluster)."
  default     = []
}

/*
aws_eks_identity_provider_config: Manages an EKS Identity Provider Configuration.
*/

variable "create_eks_identity_provider_config" {
  type        = bool
  description = "Specify whether to create this resource"
  default     = false
}

variable "oidc" {
  type        = map(string)
  description = "(Required) Nested attribute containing [OpenID Connect](https://openid.net/connect/) identity provider information for the cluster."
  default     = {}
}

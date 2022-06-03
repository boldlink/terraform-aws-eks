
variable "fargate_profiles" {
  type        = any
  description = "Fargate Profiles resource block"
  default     = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\\^[0-9A-Za-z][A-Za-z0-9-_]+$`)."
  default     = null
}

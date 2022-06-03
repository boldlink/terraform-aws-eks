terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.15.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
  required_version = ">= 0.14.11"
}

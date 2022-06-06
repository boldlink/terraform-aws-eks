terraform {
  required_providers {
    null = ">= 2.0.0"
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.15.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
  }

  required_version = ">= 0.14.11"
}

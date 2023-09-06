terraform {
  required_providers {
    null = ">= 2.0.0"
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.0.0"
    }
  }

  required_version = ">= 0.14.11"
}

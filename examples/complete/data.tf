data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_kms_alias" "supporting" {
  name = "alias/${var.supporting_resources_name}"
}

data "aws_eks_cluster" "default" {
  name = module.complete_eks_cluster.id
}

data "aws_eks_cluster_auth" "default" {
  name = module.complete_eks_cluster.id
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${var.supporting_resources_name}*.eks.pub.*"]
  }
}

data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [var.supporting_resources_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${var.supporting_resources_name}*.eks.pri.*"]
  }
}
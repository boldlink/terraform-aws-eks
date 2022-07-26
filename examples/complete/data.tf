data "aws_kms_alias" "supporting" {
  name = "alias/${local.supporting_resources_name}"
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.supporting_resources_name}*.eks.pub.*"]
  }
}

data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [local.supporting_resources_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${local.supporting_resources_name}*.eks.pri.*"]
  }
}

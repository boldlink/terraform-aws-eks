data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.supporting_resources_name}*.eks.pub.*"]
  }
}

locals {
  cluster_name              = "example-minimum-eks"
  supporting_resources_name = "terraform-aws-eks"
  vpc_id                    = data.aws_vpc.supporting.id
  public_subnets            = flatten(data.aws_subnets.public.ids)
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}

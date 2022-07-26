
locals {
  cluster_name              = "example-complete-eks"
  supporting_resources_name = "terraform-aws-eks"
  vpc_id                    = data.aws_vpc.supporting.id
  kms_key_arn               = data.aws_kms_alias.supporting.target_key_arn
  public_subnets            = flatten(data.aws_subnets.public.ids)
  private_subnets           = flatten(data.aws_subnets.private.ids)
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}


locals {
  cluster_name              = "example-complete-eks"
  supporting_resources_name = "terraform-aws-eks"
  vpc_id                    = data.aws_vpc.supporting.id
  kms_key_arn               = data.aws_kms_alias.supporting.target_key_arn
  public_subnets            = flatten(data.aws_subnets.public.ids)
  private_subnets           = flatten(data.aws_subnets.private.ids)
  tags = {
    Environment        = "example"
    Name               = local.cluster_name
    "user::CostCenter" = "terraform-registry"
    InstanceScheduler  = true
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}

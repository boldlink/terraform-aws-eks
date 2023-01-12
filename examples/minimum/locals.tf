locals {
  cluster_name              = "example-minimum-eks"
  supporting_resources_name = "terraform-aws-eks"
  vpc_id                    = data.aws_vpc.supporting.id
  public_subnets            = flatten(data.aws_subnets.public.ids)
  tags = {
    Environment        = "example"
    Name               = local.cluster_name
    "user::CostCenter" = "terraform-registry"
    InstanceScheduler  = true
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "c700-eks-module-examples"
    LayerId            = "c700"
  }
}

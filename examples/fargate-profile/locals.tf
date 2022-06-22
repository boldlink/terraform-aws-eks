
locals {
  cidr_block              = "10.0.0.0/16"
  tag_env                 = "dev"
  cluster_name            = "example-fargate-profile-cluster"
  fargate_private_subnet1 = cidrsubnet(local.cidr_block, 7, 50)
  fargate_private_subnet2 = cidrsubnet(local.cidr_block, 7, 55)
  fargate_private_subnet3 = cidrsubnet(local.cidr_block, 7, 60)
  fargate_private_subnets = [local.fargate_private_subnet1, local.fargate_private_subnet2, local.fargate_private_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
}

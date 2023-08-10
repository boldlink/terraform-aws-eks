locals {
  vpc_id         = data.aws_vpc.supporting.id
  public_subnets = flatten(data.aws_subnets.public.ids)
  tags           = var.tags
}

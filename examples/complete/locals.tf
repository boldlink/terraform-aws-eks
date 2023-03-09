
locals {
  vpc_id          = data.aws_vpc.supporting.id
  vpc_cidr        = data.aws_vpc.supporting.cidr_block
  kms_key_arn     = data.aws_kms_alias.supporting.target_key_arn
  public_subnets  = flatten(data.aws_subnets.public.ids)
  private_subnets = flatten(data.aws_subnets.private.ids)
  tags            = merge({ "Name" = var.cluster_name }, var.tags)
}

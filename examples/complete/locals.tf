
locals {
  vpc_id          = data.aws_vpc.supporting.id
  kms_key_arn     = data.aws_kms_alias.supporting.target_key_arn
  public_subnets  = flatten(data.aws_subnets.public.ids)
  private_subnets = flatten(data.aws_subnets.private.ids)
  tags            = var.tags
}

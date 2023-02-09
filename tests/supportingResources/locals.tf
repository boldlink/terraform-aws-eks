locals {
  public_subnets      = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  eks_public_subnets  = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
  private_subnets     = [cidrsubnet(local.cidr_block, 8, 7), cidrsubnet(local.cidr_block, 8, 8), cidrsubnet(local.cidr_block, 8, 9)]
  eks_private_subnets = [cidrsubnet(local.cidr_block, 8, 10), cidrsubnet(local.cidr_block, 8, 11), cidrsubnet(local.cidr_block, 8, 12)]
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.id
  dns_suffix          = data.aws_partition.current.dns_suffix
  partition           = data.aws_partition.current.partition
  azs                 = flatten(data.aws_availability_zones.available.names)
  cidr_block          = "192.169.0.0/16"
  name                = "terraform-aws-eks"
  tags = {
    environment        = "examples"
    name               = local.name
    "user::CostCenter" = "terraform-registry"
  }
  cluster_name = "example-complete-eks"

  kms_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "Administrators Roles"
          Effect = "Allow"
          Principal = {
            "AWS" = ["arn:${local.partition}:iam::${local.account_id}:root"]
          }
          Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:GenerateDataKey",
            "kms:Create*",
            "kms:Describe*",
            "kms:Enable*",
            "kms:List*",
            "kms:Put*",
            "kms:Update*",
            "kms:Revoke*",
            "kms:Disable*",
            "kms:Get*",
            "kms:Delete*",
            "kms:TagResource",
            "kms:UntagResource",
            "kms:ScheduleKeyDeletion",
            "kms:CancelKeyDeletion"
          ]
          Resource = ["*"]
        },
        {
          Sid    = "Allowed Key usage Logs"
          Effect = "Allow"
          Principal = {
            Service = ["logs.${local.region}.${local.dns_suffix}"]
          }
          Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey",
            "kms:CreateGrant",
            "kms:DescribeKey"
          ]
          Resource = ["*"]
          Condition = {
            StringLike = {
              "kms:EncryptionContext:${local.partition}:logs:arn" = ["arn:${local.partition}:logs:${local.region}:${local.account_id}:log-group:*"]
            }
          }
        },
        {
          Sid    = "Allowed Key usage Services"
          Effect = "Allow"
          Principal = {
            "AWS" = ["*"]
          }
          Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey",
            "kms:CreateGrant",
            "kms:DescribeKey"
          ]
          Resource = ["*"]
          Condition = {
            StringEquals = {
              "kms:CallerAccount" = [data.aws_caller_identity.current.account_id]
            }
          }
        }
  ] })
}

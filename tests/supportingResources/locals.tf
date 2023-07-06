locals {
  public_subnets      = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  eks_public_subnets  = [cidrsubnet(var.cidr_block, 8, 4), cidrsubnet(var.cidr_block, 8, 5), cidrsubnet(var.cidr_block, 8, 6)]
  private_subnets     = [cidrsubnet(var.cidr_block, 8, 7), cidrsubnet(var.cidr_block, 8, 8), cidrsubnet(var.cidr_block, 8, 9)]
  eks_private_subnets = [cidrsubnet(var.cidr_block, 8, 10), cidrsubnet(var.cidr_block, 8, 11), cidrsubnet(var.cidr_block, 8, 12)]
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.id
  dns_suffix          = data.aws_partition.current.dns_suffix
  partition           = data.aws_partition.current.partition

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
              "kms:CallerAccount" = [local.account_id]
            }
          }
        }
  ] })
}

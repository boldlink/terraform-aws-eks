locals {
  account_id         = data.aws_caller_identity.current.account_id
  dns_suffix         = data.aws_partition.current.dns_suffix
  region             = data.aws_region.current.id
  partition          = data.aws_partition.current.partition
  node_iam_role_arns = flatten(concat([for node in module.fargate_profile : node.role_arn], [for node in module.node_group : node.role_arn], var.aws_auth_node_iam_role_arns))
  aws_auth_data = {
    mapRoles = yamlencode(concat(
      [for role_arn in local.node_iam_role_arns : {
        rolearn  = role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
        ]
        }
      ],
      var.aws_auth_roles
    ))
    mapUsers    = yamlencode(var.aws_auth_users)
    mapAccounts = yamlencode(var.aws_auth_accounts)
  }
  kms_policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "key-default-1",
    "Statement" : [{
      "Sid" : "Enable IAM User Permissions",
      "Effect" : "Allow",
      "Principal" : {
        "AWS" : "arn:${local.partition}:iam::${local.account_id}:root"
      },
      "Action" : "kms:*",
      "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Principal" : { "Service" : "logs.${local.region}.${local.dns_suffix}" },
        "Action" : [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

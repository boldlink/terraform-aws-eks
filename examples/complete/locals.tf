locals {
  account_id      = data.aws_caller_identity.current.account_id
  partition       = data.aws_partition.current.partition
  dns_suffix      = data.aws_partition.current.dns_suffix
  vpc_id          = data.aws_vpc.supporting.id
  kms_key_arn     = data.aws_kms_alias.supporting.target_key_arn
  public_subnets  = flatten(data.aws_subnets.public.ids)
  private_subnets = flatten(data.aws_subnets.private.ids)
  tags            = merge({ "Name" = var.cluster_name }, var.tags)

  kms_policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "key-policy-1",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${local.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow Autoscaling service-linked role use of the customer managed key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:${local.partition}:iam::${local.account_id}:role/aws-service-role/autoscaling.${local.dns_suffix}/AWSServiceRoleForAutoScaling"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow EKS Nodes to Use the Key",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      }
    ]
    }
  )

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRoleWithWebIdentity"
        "Condition" : {
          "StringEquals" : {
            "${replace(module.complete_eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:aud" : "sts.amazonaws.com",
            "${replace(module.complete_eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
        "Effect" : "Allow"
        "Sid" : "EBSDriverRole"
        "Principal" : {
          "Federated" : module.complete_eks_cluster.oidc_arn[0]
        }
      },
    ]
  })
}

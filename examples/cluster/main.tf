##tag with kubernetes.io/cluster/CLUSTER_NAME

data "aws_vpc" "default" {
  default = true
}

locals {
  cluster_name = "test-cluster5"
  role_name    = "eks-test-role"
  cidr_block1  = cidrsubnet(data.aws_vpc.default.cidr_block, 8, 65)
  cidr_block2  = cidrsubnet(data.aws_vpc.default.cidr_block, 8, 70)
  cidr_blocks  = [local.cidr_block1, local.cidr_block2]
}

module "eks_role" {
  source                = "boldlink/iam-role/aws"
  version               = "1.0.0"
  name                  = local.role_name
  assume_role_policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  description           = "Role for eks cluster permissions"
  force_detach_policies = true
}

module "eks_cluster_subnets" {
  source             = "boldlink/subnet/aws"
  version            = "1.0.0"
  vpc_id             = data.aws_vpc.default.id
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  cidr_blocks        = local.cidr_blocks
  tags = {
    Name = "kubernetes.io/cluster/${local.cluster_name}"
  }
}

module "test_eks_cluster" {
  source                    = "./../.."
  enabled_cluster_log_types = ["api", "audit"]
  name                      = local.cluster_name
  role_arn                  = module.eks_role.arn
  cluster_subnet_ids        = module.eks_cluster_subnets.id
}

resource "aws_iam_role_policy_attachment" "managed-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = module.eks_role.name
}

resource "aws_cloudwatch_log_group" "main" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${local.cluster_name}/cluster"
  retention_in_days = 7
}

output "outputs" {
  value = [
    module.eks_role,
    module.eks_cluster_subnets,
    module.test_eks_cluster
  ]
}

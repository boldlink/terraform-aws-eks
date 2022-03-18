# cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster_subnets"></a> [eks\_cluster\_subnets](#module\_eks\_cluster\_subnets) | boldlink/subnet/aws | 1.0.0 |
| <a name="module_eks_role"></a> [eks\_role](#module\_eks\_role) | boldlink/iam-role/aws | 1.0.0 |
| <a name="module_test_eks_cluster"></a> [test\_eks\_cluster](#module\_test\_eks\_cluster) | ./../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role_policy_attachment.managed-AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

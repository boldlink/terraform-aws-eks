[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-eks/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-eks.svg)](https://github.com/boldlink/terraform-aws-eks/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS EKS Terraform module

## Description
This is a detailed terraform module that can be used to create AWS EKS Cluster, Node Group and Associated resources

### Why choose this module over the standard resources
- By using the least possible minimal configuration, you can create an EKS cluster, establish a Fargate profile, and configure node groups. The aim is to streamline the setup process, making it more accessible and efficient.
- It has incorporated AWS security best practices to ensure that the infrastructure you build complies with AWS security guidelines. We use Checkov to validate compliance and enhance security.
- The module detailed examples that walk you through the setup procedure. Whether you're new to EKS or an experienced user, you'll find these examples helpful for quick and effective cluster configuration.
- You can easily modify or create new ConfigMaps to tailor your cluster's configurations to your application's requirements.
- This module features a fully customizable launch template. This allows you to fine-tune the template according to your specific needs, ensuring that it aligns perfectly with your infrastructure requirements.

Examples available [here](./examples)

**Note on Using Custom Public Access CIDRS**
- If you restrict access to your public endpoint using CIDR blocks, it is recommended that you also enable private endpoint access so that nodes and Fargate pods (if you use them) can communicate with the cluster. Without the private endpoint enabled, your public access endpoint CIDR sources must include the egress sources from your VPC. For example, if you have a node in a private subnet that communicates to the internet through a NAT Gateway, you will need to add the outbound IP address of the NAT gateway as part of an allowed CIDR block on your public endpoint.
- Use your own public access CIDR block(s), otherwise you will encounter an error.
see more [here](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html)

## Connecting to Nodes Using SSM
- By default this module does not enable ssm agent installation on the nodes when the option `create_custom_launch_template` is enabled. To install ssm agent specify `install_ssm_agent = true`

## Permissions when Using encrypted ebs for launch template and custom security groups
### KMS
Allow the following kms actions in the kms policy document for Autoscaling service-linked role
```
"kms:Encrypt",
"kms:Decrypt",
"kms:ReEncrypt*",
"kms:GenerateDataKey*",
"kms:DescribeKey"
```

for example:
```json
 {
        "Sid" : "Allow Autoscaling service-linked role use of the customer managed key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:${local.partition}:iam::${local.account_id}:role/aws-service-role/autoscaling.${local.dns_suffix}/AWSServiceRoleForAutoScaling"
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
```

See complete example for more.

### Custom Security groups
See AWS documentation [here](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) and [here](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html#launch-template-security-groups) for requirements of using a custom security group for the launch template

### Using AWS CLI to start Systems Manager Session
- Make sure you have the Session Manager plugin installed on your system. For installation instructions, refer to the guide [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- Run the following command to start session from your terminal
```console
aws ssm start-session \
    --target "<instance_id>"
```
Replace `<instance_id>` with the ID of the instance you want to connect to

## Launching in Private Subnets without NAT Gateways or internet connection
To manage instances in isolated subnets without internet connectivity, it is necessary to enable VPC endpoints for specific services, including:
- `com.amazonaws.[region].ssm`
- `com.amazonaws.[region].ec2messages`
- `com.amazonaws.[region].ssmmessages`
- `(optional) com.amazonaws.[region].kms for KMS encryption in Session Manager`

You can use Boldlink VPC Endpoints Terraform module [here](https://github.com/boldlink/terraform-aws-vpc-endpoints/tree/main/examples)

## Usage
**NOTE**: These examples use the latest version of this module

```hcl
module "minimum_eks_cluster" {
  source                    = "boldlink/eks/aws"
  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  cluster_name              = local.cluster_name
  vpc_id                    = local.vpc_id
  cluster_subnet_ids        = local.public_subnets
  tags                      = local.tags
}
```

```hcl
locals {
  cluster_name              = "example-minimum-eks"
  supporting_resources_name = "terraform-aws-eks"
  vpc_id                    = data.aws_vpc.supporting.id
  public_subnets            = flatten(data.aws_subnets.public.ids)
  tags = {
    Environment        = "example"
    Name               = local.cluster_name
    "user::CostCenter" = "terraform-registry"
    InstanceScheduler  = true
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "c700-eks-module-examples"
    LayerId            = "c700"
  }
}
```

```hcl
data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [local.supporting_resources_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.supporting_resources_name}*.eks.pub.*"]
  }
}
```

## Documentation

[Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.20.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.23.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fargate_profile"></a> [fargate\_profile](#module\_fargate\_profile) | ./modules/fargate-profile | n/a |
| <a name="module_node_group"></a> [node\_group](#module\_node\_group) | ./modules/managed-node-group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_identity_provider_config.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config) | resource |
| [aws_iam_openid_connect_provider.irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.ekscluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazoneksclusterpolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazoneksvpccontroller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_config_map.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map_v1_data.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.eks_cluster_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [tls_certificate.irsa](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_auth_accounts"></a> [aws\_auth\_accounts](#input\_aws\_auth\_accounts) | List of account maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_aws_auth_node_iam_role_arns"></a> [aws\_auth\_node\_iam\_role\_arns](#input\_aws\_auth\_node\_iam\_role\_arns) | List of node IAM role ARNs to add to the aws-auth configmap | `list(string)` | `[]` | no |
| <a name="input_aws_auth_roles"></a> [aws\_auth\_roles](#input\_aws\_auth\_roles) | List of IAM role ARNs to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_aws_auth_users"></a> [aws\_auth\_users](#input\_aws\_auth\_users) | List of user maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\^[0-9A-Za-z][A-Za-z0-9-_]+$`). | `string` | `null` | no |
| <a name="input_cluster_subnet_ids"></a> [cluster\_subnet\_ids](#input\_cluster\_subnet\_ids) | (Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane. | `list(string)` | n/a | yes |
| <a name="input_create_aws_auth"></a> [create\_aws\_auth](#input\_create\_aws\_auth) | Choose whether to create the aws-auth configmap- used when aws-auth configmap doesn't exist | `bool` | `false` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | (Optional) The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. | `number` | `30` | no |
| <a name="input_eks_addons"></a> [eks\_addons](#input\_eks\_addons) | EKS Addons resource block | `any` | `{}` | no |
| <a name="input_enable_cp_logging"></a> [enable\_cp\_logging](#input\_enable\_cp\_logging) | Determine whether to enable control plane logging | `bool` | `true` | no |
| <a name="input_enable_fargate_node_groups"></a> [enable\_fargate\_node\_groups](#input\_enable\_fargate\_node\_groups) | Set this variable to true to create your fargate node groups | `bool` | `false` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable Open Identity connect support for AWS IAM Roles | `bool` | `false` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | (Optional) Specifies whether key rotation is enabled. Defaults to false. | `bool` | `true` | no |
| <a name="input_enable_managed_node_groups"></a> [enable\_managed\_node\_groups](#input\_enable\_managed\_node\_groups) | Set this variable to true to create your managed node groups | `bool` | `false` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | (Optional) List of the desired control plane logging to enable. | `list(string)` | `[]` | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | (Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is `false`. | `bool` | `true` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | (Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is `true`. | `bool` | `false` | no |
| <a name="input_fargate_node_groups"></a> [fargate\_node\_groups](#input\_fargate\_node\_groups) | Map of EKS fargate node group definitions to create | `any` | `{}` | no |
| <a name="input_identity_providers"></a> [identity\_providers](#input\_identity\_providers) | Identity providers resources block | `any` | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | (Optional) Ingress rules to add to the security group | `any` | `{}` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Amazon Resource Name (ARN) of the KMS Key to use when encrypting | `string` | `null` | no |
| <a name="input_kubernetes_master_version"></a> [kubernetes\_master\_version](#input\_kubernetes\_master\_version) | (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS. | `string` | `null` | no |
| <a name="input_kubernetes_network_config"></a> [kubernetes\_network\_config](#input\_kubernetes\_network\_config) | (Optional) Configuration block with kubernetes network configuration for the cluster. | `map(string)` | `{}` | no |
| <a name="input_log_group_retention_days"></a> [log\_group\_retention\_days](#input\_log\_group\_retention\_days) | Number of days the log group is retained before it is deleted | `number` | `7` | no |
| <a name="input_managed_node_groups"></a> [managed\_node\_groups](#input\_managed\_node\_groups) | Map of EKS managed node group definitions to create | `any` | `{}` | no |
| <a name="input_modify_aws_auth"></a> [modify\_aws\_auth](#input\_modify\_aws\_auth) | Choose whether to manage the aws-auth configmap | `bool` | `false` | no |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://www.terraform.io../docs?_ga=2.83681619.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Configuration specifying how long to wait for the EKS Node Group to be created, updated and deleted | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) VPC ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the cluster. |
| <a name="output_certificate_authority"></a> [certificate\_authority](#output\_certificate\_authority) | Attribute block containing `certificate-authority-data` for your cluster |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The cluster version of the eks cluster |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Unix epoch timestamp in seconds for when the cluster was created. |
| <a name="output_eks_addon_arn"></a> [eks\_addon\_arn](#output\_eks\_addon\_arn) | Amazon Resource Name (ARN) of the EKS add-on. |
| <a name="output_eks_addon_created_at"></a> [eks\_addon\_created\_at](#output\_eks\_addon\_created\_at) | Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was created. |
| <a name="output_eks_addon_id"></a> [eks\_addon\_id](#output\_eks\_addon\_id) | EKS Cluster name and EKS Addon name separated by a colon (`:`). |
| <a name="output_eks_addon_modified_at"></a> [eks\_addon\_modified\_at](#output\_eks\_addon\_modified\_at) | Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was updated. |
| <a name="output_eks_addon_status"></a> [eks\_addon\_status](#output\_eks\_addon\_status) | Status of the EKS add-on(s). |
| <a name="output_eks_addon_tags_all"></a> [eks\_addon\_tags\_all](#output\_eks\_addon\_tags\_all) | (Optional) Key-value map of resource tags, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_eks_identity_provider_config_arn"></a> [eks\_identity\_provider\_config\_arn](#output\_eks\_identity\_provider\_config\_arn) | Amazon Resource Name (ARN) of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_config_id"></a> [eks\_identity\_provider\_config\_id](#output\_eks\_identity\_provider\_config\_id) | EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (`:`). |
| <a name="output_eks_identity_provider_config_status"></a> [eks\_identity\_provider\_config\_status](#output\_eks\_identity\_provider\_config\_status) | Status of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_config_tags_all"></a> [eks\_identity\_provider\_config\_tags\_all](#output\_eks\_identity\_provider\_config\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.7472759.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Endpoint for your Kubernetes API server. |
| <a name="output_fargate_role_arn"></a> [fargate\_role\_arn](#output\_fargate\_role\_arn) | The name of the node group IAM role |
| <a name="output_fargate_role_name"></a> [fargate\_role\_name](#output\_fargate\_role\_name) | ARN of the node group IAM role |
| <a name="output_id"></a> [id](#output\_id) | Name of the cluster. |
| <a name="output_identity"></a> [identity](#output\_identity) | Attribute block containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019. |
| <a name="output_managed_role_arn"></a> [managed\_role\_arn](#output\_managed\_role\_arn) | The name of the node group IAM role |
| <a name="output_managed_role_name"></a> [managed\_role\_name](#output\_managed\_role\_name) | ARN of the node group IAM role |
| <a name="output_oidc_arn"></a> [oidc\_arn](#output\_oidc\_arn) | The name of the node group IAM role |
| <a name="output_platform_version"></a> [platform\_version](#output\_platform\_version) | Platform version for the cluster. |
| <a name="output_status"></a> [status](#output\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block). |
| <a name="output_vpc_config"></a> [vpc\_config](#output\_vpc\_config) | Configuration block argument that also includes attributes for the VPC associated with your cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `tests/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```
#### BOLDLink-SIG 2023

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

# terraform-aws-eks supporting resources

These stacks are to be used on the examples testing and where setup to minimum dependencies,
they are not in any way the recommended setup for a production grade implementation.


This stack builds:
* VPC with public and Private subnets
* KMS key to be used by eks and cloudwatch logs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.15.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete_managed_policy"></a> [complete\_managed\_policy](#module\_complete\_managed\_policy) | boldlink/iam-role/aws | 1.1.0 |
| <a name="module_eks_vpc"></a> [eks\_vpc](#module\_eks\_vpc) | boldlink/vpc/aws | 3.0.4 |
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | boldlink/kms/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR block | `string` | `"192.169.0.0/16"` | no |
| <a name="input_create_kms_alias"></a> [create\_kms\_alias](#input\_create\_kms\_alias) | Whether to create CMK kms alias | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the CMK kms key | `string` | `"kms key for eks module secrets"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the stack | `string` | `"terraform-aws-eks"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the eks resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "InstanceScheduler": true,<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
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

Some of the modules have dependencies on other modules (ex. Ec2 instance dependns on the VPC) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

### Makefile
The makefile contain in this repo is optimised for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done seperatly so you can test your module build/modify/destroy independatly.
```console
make cleansupporting
```

#### BOLDLink-SIG 2023

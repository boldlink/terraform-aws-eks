[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS-EKS-fargate-profile Terraform module

<Description>

This terraform sub-module Manages an EKS Fargate Profile.

Examples available [`here`](https://github.com/boldlink/terraform-aws-eks/tree/main/examples)

## Documentation

[Amazon Documentation](https://docs.aws.amazon.com/eks/latest/userguide/fargate.html)

[Terraform module documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.15.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_fargate_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\^[0-9A-Za-z][A-Za-z0-9-_]+$`). | `string` | `null` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Fargate Profiles resource block | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fargate_profile_arn"></a> [fargate\_profile\_arn](#output\_fargate\_profile\_arn) | Amazon Resource Name (ARN) of the EKS Fargate Profile. |
| <a name="output_fargate_profile_id"></a> [fargate\_profile\_id](#output\_fargate\_profile\_id) | EKS Cluster name and EKS Fargate Profile name separated by a colon (:). |
| <a name="output_fargate_profile_status"></a> [fargate\_profile\_status](#output\_fargate\_profile\_status) | Status of the EKS Fargate Profile. |
| <a name="output_fargate_profile_tags_all"></a> [fargate\_profile\_tags\_all](#output\_fargate\_profile\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.247767490.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
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

#### BOLDLink-SIG 2022

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-eks/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-eks.svg)](https://github.com/boldlink/terraform-aws-eks/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform  module example of complete and most common configuration

This example is for demo and testing purposes and doesn't represent a production grade implementation.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.15.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.28.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete_eks_cluster"></a> [complete\_eks\_cluster](#module\_complete\_eks\_cluster) | ./../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_kms_alias.supporting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.supporting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

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

#### BOLDLink-SIG 2022

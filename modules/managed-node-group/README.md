[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-eks/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-eks.svg)](https://github.com/boldlink/terraform-aws-eks/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS EKS managed-node-group Terraform module

<Description>

This terraform sub-module adds a managed eks node group.

```console
module "node_group" {
  source                 = "boldlink/eks/aws//modules/managed-node-group"
  cluster_name           = var.cluster_name
  create_key_pair        = var.create_key_pair
  desired_size           = var.desired_size
  max_size               = var.max_size
  min_size               = var.min_size
  update_config          = var.update_config
  node_group_subnet_ids  = var.node_group_subnet_ids
  ami_type               = var.ami_type
  capacity_type          = capacity_type
  disk_size              = var.disk_size
  force_update_version   = var.force_update_version
  instance_types         = var.instance_types
  labels                 = var.labels
  launch_template        = var.launch_template
  node_group_name        = var.node_group_name
  node_group_name_prefix = var.node_group_name_prefix
  release_version        = var.release_version
  remote_access          = var.remote_access
  tags                   = var.tags
  taint                  = var.taint
  kubernetes_version     = var.kubernetes_version
  timeouts               = var.timeouts
}
```

## Documentation

[Amazon Documentation](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html)

[Terraform module documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.15.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_registry_readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [null_resource.local_save_ec2_keypair](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. | `string` | `"BOTTLEROCKET_x86_64"` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | (Optional) Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`. | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\^[0-9A-Za-z][A-Za-z0-9-_]+$`). | `string` | n/a | yes |
| <a name="input_create_key_pair"></a> [create\_key\_pair](#input\_create\_key\_pair) | Whether or not to create a key pair | `bool` | `false` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | (Required) Desired number of worker nodes. | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | (Optional) Disk size in GiB for worker nodes. Defaults to 20. | `number` | `null` | no |
| <a name="input_force_update_version"></a> [force\_update\_version](#input\_force\_update\_version) | (Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue. | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. Defaults to `[t3.medium]`. | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (Optional) Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed. | `map(string)` | `{}` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | (Optional) Configuration block with Launch Template settings. | `map(string)` | `{}` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | (Required) Maximum number of worker nodes, recommend multiples of 3. | `number` | `3` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | (Required) Minimum number of worker nodes. | `number` | `1` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | (Optional) Name of the EKS Node Group. If omitted, Terraform will assign a random, unique name. Conflicts with `node_group_name_prefix`. | `string` | `null` | no |
| <a name="input_node_group_name_prefix"></a> [node\_group\_name\_prefix](#input\_node\_group\_name\_prefix) | (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `node_group_name`. | `string` | `null` | no |
| <a name="input_node_group_subnet_ids"></a> [node\_group\_subnet\_ids](#input\_node\_group\_subnet\_ids) | (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME` (where `CLUSTER_NAME` is replaced with the name of the EKS Cluster). | `list(string)` | n/a | yes |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | (Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version. | `string` | `null` | no |
| <a name="input_remote_access"></a> [remote\_access](#input\_remote\_access) | (Optional) Configuration block with remote access settings. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://www.terraform.io../docs?_ga=2.83681619.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_taint"></a> [taint](#input\_taint) | (Optional) The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Configuration specifying how long to wait for the EKS Node Group to be created, updated and deleted | `map(string)` | `{}` | no |
| <a name="input_update_config"></a> [update\_config](#input\_update\_config) | (Optional) Desired max number/max percentage of unavailable worker nodes during node group update. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_node_group_arn"></a> [eks\_node\_group\_arn](#output\_eks\_node\_group\_arn) | Amazon Resource Name (ARN) of the EKS Node Group. |
| <a name="output_eks_node_group_id"></a> [eks\_node\_group\_id](#output\_eks\_node\_group\_id) | EKS Cluster name and EKS Node Group name separated by a colon (`:`). |
| <a name="output_eks_node_group_resources"></a> [eks\_node\_group\_resources](#output\_eks\_node\_group\_resources) | List of objects containing information about underlying resources. |
| <a name="output_eks_node_group_status"></a> [eks\_node\_group\_status](#output\_eks\_node\_group\_status) | Status of the EKS Node Group. |
| <a name="output_eks_node_group_tags_all"></a> [eks\_node\_group\_tags\_all](#output\_eks\_node\_group\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.50114275.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the node group IAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the node group IAM role |
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

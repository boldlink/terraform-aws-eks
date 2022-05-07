
[![Build Status](https://github.com/boldlink/terraform-aws-eks/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/boldlink/terraform-aws-eks/actions)

# AWS EKS Terraform module

## Description
This is a detailed terraform module that can be used to create AWS EKS Cluster, Node Group and Associated resources

Example available [here](https://github.com/boldlink/terraform-aws-eks/tree/main/examples)

## Documentation

[Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_fargate_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_identity_provider_config.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config) | resource |
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_name"></a> [addon\_name](#input\_addon\_name) | (Required) Name of the EKS add-on. | `string` | `""` | no |
| <a name="input_addon_version"></a> [addon\_version](#input\_addon\_version) | (Optional) The version of the EKS add-on. The version must match one of the versions returned by [describe-addon-versions](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html). | `string` | `null` | no |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. | `string` | `null` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | (Optional) Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`. | `string` | `null` | no |
| <a name="input_cluster_subnet_ids"></a> [cluster\_subnet\_ids](#input\_cluster\_subnet\_ids) | (Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane. | `list(string)` | n/a | yes |
| <a name="input_create_eks_addon"></a> [create\_eks\_addon](#input\_create\_eks\_addon) | choose whether to create eks addon | `bool` | `false` | no |
| <a name="input_create_eks_fargate_profile"></a> [create\_eks\_fargate\_profile](#input\_create\_eks\_fargate\_profile) | Specify whether to create this resource or not | `bool` | `false` | no |
| <a name="input_create_eks_identity_provider_config"></a> [create\_eks\_identity\_provider\_config](#input\_create\_eks\_identity\_provider\_config) | Specify whether to create this resource | `bool` | `false` | no |
| <a name="input_create_eks_node_group"></a> [create\_eks\_node\_group](#input\_create\_eks\_node\_group) | Specify whether to create node group or not | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | (Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided. | `number` | `null` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | (Optional) List of the desired control plane logging to enable. | `list(string)` | `[]` | no |
| <a name="input_encryption_config"></a> [encryption\_config](#input\_encryption\_config) | (Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020. | `map(string)` | `{}` | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | (Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is `false`. | `bool` | `false` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | (Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is `true`. | `bool` | `true` | no |
| <a name="input_fargate_profile_name"></a> [fargate\_profile\_name](#input\_fargate\_profile\_name) | (Required) Name of the EKS Fargate Profile. | `string` | `""` | no |
| <a name="input_fargate_profile_subnet_ids"></a> [fargate\_profile\_subnet\_ids](#input\_fargate\_profile\_subnet\_ids) | (Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME` (where `CLUSTER_NAME` is replaced with the name of the EKS Cluster). | `list(string)` | `[]` | no |
| <a name="input_force_update_version"></a> [force\_update\_version](#input\_force\_update\_version) | (Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue. | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. Defaults to `[t3.medium]`. | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_kubernetes_master_version"></a> [kubernetes\_master\_version](#input\_kubernetes\_master\_version) | (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS. | `string` | `null` | no |
| <a name="input_kubernetes_network_config"></a> [kubernetes\_network\_config](#input\_kubernetes\_network\_config) | (Optional) Configuration block with kubernetes network configuration for the cluster. | `map(string)` | `{}` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (Optional) Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed. | `map(string)` | `{}` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | (Optional) Configuration block with Launch Template settings. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (`\^[0-9A-Za-z][A-Za-z0-9-_]+$`). | `string` | n/a | yes |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | (Optional) Name of the EKS Node Group. If omitted, Terraform will assign a random, unique name. Conflicts with `node_group_name_prefix`. | `string` | `null` | no |
| <a name="input_node_group_name_prefix"></a> [node\_group\_name\_prefix](#input\_node\_group\_name\_prefix) | (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `node_group_name`. | `string` | `null` | no |
| <a name="input_node_group_subnet_ids"></a> [node\_group\_subnet\_ids](#input\_node\_group\_subnet\_ids) | (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME` (where `CLUSTER_NAME` is replaced with the name of the EKS Cluster). | `list(string)` | `[]` | no |
| <a name="input_node_role_arn"></a> [node\_role\_arn](#input\_node\_role\_arn) | (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group. | `string` | `""` | no |
| <a name="input_oidc"></a> [oidc](#input\_oidc) | (Required) Nested attribute containing [OpenID Connect](https://openid.net/connect/) identity provider information for the cluster. | `map(string)` | `{}` | no |
| <a name="input_pod_execution_role_arn"></a> [pod\_execution\_role\_arn](#input\_pod\_execution\_role\_arn) | (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile. | `string` | `""` | no |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | (Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version. | `string` | `null` | no |
| <a name="input_remote_access"></a> [remote\_access](#input\_remote\_access) | (Optional) Configuration block with remote access settings. | `map(string)` | `{}` | no |
| <a name="input_resolve_conflicts"></a> [resolve\_conflicts](#input\_resolve\_conflicts) | (Optional) Define how to resolve parameter value conflicts when migrating an existing add-on to an Amazon EKS add-on or when applying version updates to the add-on. Valid values are `NONE` and `OVERWRITE`. | `string` | `null` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | (Required) ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. Ensure the resource configuration includes explicit dependencies on the IAM Role permissions by adding depends\_on if using the aws\_iam\_role\_policy resource or aws\_iam\_role\_policy\_attachment resource, otherwise EKS cannot delete EKS managed EC2 infrastructure such as Security Groups on EKS Cluster deletion. | `string` | n/a | yes |
| <a name="input_scaling_config"></a> [scaling\_config](#input\_scaling\_config) | (Required) Configuration block with scaling settings. | `map(string)` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. | `list(string)` | `[]` | no |
| <a name="input_selector"></a> [selector](#input\_selector) | (Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile. | `map(string)` | `{}` | no |
| <a name="input_service_account_role_arn"></a> [service\_account\_role\_arn](#input\_service\_account\_role\_arn) | (Optional) The Amazon Resource Name (ARN) of an existing IAM role to bind to the add-on's service account. The role must be assigned the IAM permissions required by the add-on. If you don't specify an existing IAM role, then the add-on uses the permissions assigned to the node IAM role. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://www.terraform.io../docs?_ga=2.83681619.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_taint"></a> [taint](#input\_taint) | (Optional) The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Configuration specifying how long to wait for the EKS Node Group to be created, updated and deleted | `map(string)` | `{}` | no |
| <a name="input_update_config"></a> [update\_config](#input\_update\_config) | (Optional) Desired max number/max percentage of unavailable worker nodes during node group update. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the cluster. |
| <a name="output_certificate_authority"></a> [certificate\_authority](#output\_certificate\_authority) | Attribute block containing `certificate-authority-data` for your cluster |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Unix epoch timestamp in seconds for when the cluster was created. |
| <a name="output_eks_addon_arn"></a> [eks\_addon\_arn](#output\_eks\_addon\_arn) | Amazon Resource Name (ARN) of the EKS add-on. |
| <a name="output_eks_addon_created_at"></a> [eks\_addon\_created\_at](#output\_eks\_addon\_created\_at) | Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was created. |
| <a name="output_eks_addon_id"></a> [eks\_addon\_id](#output\_eks\_addon\_id) | EKS Cluster name and EKS Addon name separated by a colon (`:`). |
| <a name="output_eks_addon_modified_at"></a> [eks\_addon\_modified\_at](#output\_eks\_addon\_modified\_at) | Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was updated. |
| <a name="output_eks_addon_status"></a> [eks\_addon\_status](#output\_eks\_addon\_status) | Status of the EKS add-on. |
| <a name="output_eks_addon_tags_all"></a> [eks\_addon\_tags\_all](#output\_eks\_addon\_tags\_all) | (Optional) Key-value map of resource tags, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_eks_identity_provider_config_arn"></a> [eks\_identity\_provider\_config\_arn](#output\_eks\_identity\_provider\_config\_arn) | Amazon Resource Name (ARN) of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_config_id"></a> [eks\_identity\_provider\_config\_id](#output\_eks\_identity\_provider\_config\_id) | EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (`:`). |
| <a name="output_eks_identity_provider_config_status"></a> [eks\_identity\_provider\_config\_status](#output\_eks\_identity\_provider\_config\_status) | Status of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_config_tags_all"></a> [eks\_identity\_provider\_config\_tags\_all](#output\_eks\_identity\_provider\_config\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.7472759.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
| <a name="output_eks_node_group_arn"></a> [eks\_node\_group\_arn](#output\_eks\_node\_group\_arn) | Amazon Resource Name (ARN) of the EKS Node Group. |
| <a name="output_eks_node_group_id"></a> [eks\_node\_group\_id](#output\_eks\_node\_group\_id) | EKS Cluster name and EKS Node Group name separated by a colon (`:`). |
| <a name="output_eks_node_group_resources"></a> [eks\_node\_group\_resources](#output\_eks\_node\_group\_resources) | List of objects containing information about underlying resources. |
| <a name="output_eks_node_group_status"></a> [eks\_node\_group\_status](#output\_eks\_node\_group\_status) | Status of the EKS Node Group. |
| <a name="output_eks_node_group_tags_all"></a> [eks\_node\_group\_tags\_all](#output\_eks\_node\_group\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.50114275.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Endpoint for your Kubernetes API server. |
| <a name="output_fargate_profile_arn"></a> [fargate\_profile\_arn](#output\_fargate\_profile\_arn) | Amazon Resource Name (ARN) of the EKS Fargate Profile. |
| <a name="output_fargate_profile_id"></a> [fargate\_profile\_id](#output\_fargate\_profile\_id) | EKS Cluster name and EKS Fargate Profile name separated by a colon (:). |
| <a name="output_fargate_profile_status"></a> [fargate\_profile\_status](#output\_fargate\_profile\_status) | Status of the EKS Fargate Profile. |
| <a name="output_fargate_profile_tags_all"></a> [fargate\_profile\_tags\_all](#output\_fargate\_profile\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://www.terraform.io/docs/providers/aws/index.html?_ga=2.247767490.418379771.1647510647-1464713173.1641542419#default_tags-configuration-block). |
| <a name="output_id"></a> [id](#output\_id) | Name of the cluster. |
| <a name="output_identity"></a> [identity](#output\_identity) | Attribute block containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019. |
| <a name="output_platform_version"></a> [platform\_version](#output\_platform\_version) | Platform version for the cluster. |
| <a name="output_status"></a> [status](#output\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block). |
| <a name="output_vpc_config"></a> [vpc\_config](#output\_vpc\_config) | Configuration block argument that also includes attributes for the VPC associated with your cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

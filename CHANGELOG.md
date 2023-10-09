# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- fix: CKV_AWS_79:Ensure Instance Metadata Service Version 1 is not enabled"
- fix: CKV_AWS_341:Ensure Launch template should not have a metadata response hop limit greater than 1
- feat: showcase additional launch template configurations, for example, `instance_market_options` in the complete example
- feat: Add gp3 kms encryption for ebs volumes attached on the managed and self managed node groups (launch template).
- feat: Add self-managed node-group for fully customizable cluster deployments, [for example windows node groups.](https://github.com/aws/containers-roadmap/issues/584).
- feat: Add EKS vpc-cni add-on to the module with the iam role and service account IAM permissions (optional with true/false choice).
- feat: Add EKS ebs-csi add-on and the gp3 with encryption storageClass and service account IAM permissions (optional with true/false choice).
- feat: Add EKS CoreDNS add-on Kube-proxy (optional with true/false choice).
- feat: Add EKS ADOT Operator add-on and service account IAM permissions (optional with true/false choice).
- feat: Add a default managed node group with documented default values that gets created if var.enable_managed_node_group = true and var.managed_node_groups = {} (use less code to create a operational eks cluster).
- feat: Add container insights support for metrics and log groups.
- feat: Make all values of the tls_key variables not hardcoded values.
- feat: Add the capacity for additional policies or override default attached policies to both the cluster and node group iam roles.
- fix: CKV_AWS_39: "Ensure Amazon EKS public endpoint disabled"
- fix: CKV_AWS_38: "Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0"
- fix: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
- fix: CKV_AWS_338: "Ensure CloudWatch log groups retains logs for at least 1 year"
- feat: create a fargate profile only example that has coredns addon enabled
- fix: remove CKV_AWS_37 from `.checkov.yml` file which is being flagged even though logging for all log types has been enabled.


## [3.3.3] - 2023-10-08
- fix: fargate_profile timeouts block
- fix: managed nodegroup update_config block
- fix: eks addons block
- added an eks addon in complete example
- showed how to customize the following launch template blocks: capacity_reservation_specification, cpu_credits,enable_monitoring, enclave options and network_interfaces in the complete example
- showed how to configure identity_providers in the complete example
- added a custom kubernetes_network_config block in complete example
- removed elastic_inference_accelerator and instance_market_options blocks in launch template resource
- removed security group example in complete example to show network interface configuration

## [3.3.2] - 2023-09-21
- fix: fixed `vpc_security_group_ids` condition which was bringing an error as a result of not providing a suitable default value using lookup function
- feat: Added `cluster_version` to the module outputs.
- feat: Used ebs encryption for complete example with a launch template
- feat: Modified README to remove the statement about SSH and rephrased reasons to use the module

## [3.3.1] - 2023-09-20
- fix: Taints not properly set on the managed node group
- feat: Add taints to the complete example.

## [3.3.0] - 2023-09-06
- feat: Added ssm support to the managed nodes
- feat: Removed `remote_access` feature and removed key_pair support for the module. Use AWS Systems Manager to connect to the nodes
- feat: Added `launch_template` with fully customizable configurations
- feat: Added ssm installation script which will be executed by default when `create_custom_launch_template` is enabled. To prevent the script from executing disable it using `install_ssm_agent = false`
- feat: Added support for additional script apart from the main userdata when launch template is created. To run additional script provide a value for `extra_script`

## [3.2.3] - 2023-8-30
- fix: remove the lifecycle block from the managed node group sub-module to allow scaling values change to trigger changes.
- fix: add role to the supporting resources for aws-auth configmap in the complete example.
- chore: set the desired size of the node group to 3 in the complete example.

## [3.2.2] - 2023-8-14
- fix: tags missing in most module resources
- fix: oidc output error in minimum example.

## [3.2.1] - 2023-7-14
- fix: add missing output for oidc.

## [3.2.0] - 2023-07
- feat: Upgrade VPC module to v3.0.4
- feat: Move all nodes on the complete example to private subnets.

## [3.1.3] - 2023-03-23
- fix: CKV_AWS_37 "Ensure Amazon EKS control plane logging enabled for all log types"
- fix: CKV_AWS_39: "Ensure Amazon EKS public endpoint disabled"

## [3.1.2] - 2023-03-09
- fix: CKV_AWS_38 "Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0"
- fix: CKV_AWS_58 "Ensure EKS Cluster has Secrets Encryption Enabled"
- fix: Fixed encryption config block since it was flagged by checkov.

## [3.1.1] - 2023-02-07
- fix: CKV_AWS_109: Ensure IAM policies does not allow permissions management/resource exposure without constraints
- fix: CKV_AWS_111 Ensure IAM policies does not allow write access without constraints

## [3.1.0] - 2023-01-12
- fix: Use only one KMS key for secrets, cloudwatch encryption.
- Added new github workflow files & config files
- feat: create a single kms key for eks module

## [3.0.2] - 2022-08-30
fix: reference node iam arns inside the module for aws-auth configmap.

## [3.0.1] - 2022-08-26
### Description
- fix: aws-auth configmap usage; ability to either create a new one for self-managed node groups or modify an existing one.

## [3.0.0] - 2022-07-27
### Description
 - Fix security group error when using the custom launch template for eks managed nodes.
 - fix: Error when creating a cluster in a region without default vpc by specifying var.vpc_id - this applies to the example/minimum and recommend usage on README.md.
 - fix: When you specify an external kms key for the cloudwatch log group you get an error.
 - fix: Change the name of EKS iam roles to prevent name length limitation errors for managed and fargate sub-modules.
 - fix: Add missing variables options from node groups provisioning.
 - feat: Make var.cluster_name mandatory for node_groups.
 - feat: Change how the node groups are provisioned, allow to add N managed and fargate node groups within the module.
 - feat: Change the variable names that enable managed and fargate node groups creation.
 - feat: Set the node_group key_pair creation to false by default.
 - feat: Change the node_group max_size to 3 and add a recommendation in the variable.
 - feat: Make the var.node_group_subnet_ids mandatory for all node groups.
 - feat: Simplify how values are assigned to the node_group.
 - feat: Update the examples minimum and complete.
 - feat: Add irsa support with true/false option.
 - feat: Set managed node group var.ami_type to BOTTLEROCKET_x86_64 by default.
 - feat: Add private subnets for the VPC of the complete example to support fargate node groups.
 - feat: Envelop kms key policy with jsonencode() function.
 - feat: Add .checkov.yml to skip CKV_AWS_37 alert.
 - feat: Add supporting resources (vpc; kms) to be built once and used by all examples to minimize resource duplication during testing.
 - feat: Add supporting resources to makefile.
 - feat: Allow the makefile to also clean local terraform state files.
 - feat: Move tags to locals.tf on all examples.
 - feat: Add the SECURITY.md file.
 - feat: Remove the fargate-profile example since it is now part of the complete example (speeds up testing).


## [2.1.1] - 2022-07-06
### Description
 - fix: Encryption configuration
 - fix:security groups argument

## [2.1.0] - 2022-06-20
### Description
- Feature: Fargate-profile node-group
- Added: tags to all examples

## [2.0.0] - 2022-05-27
### Description
- Modules structure refactored
- Cluster security Group
- Cluster logs and secrets encryption
- EKS managed node-group sub-module
- Standard files added
- Complete and minimum examples
- Checkov security check fixes

## [1.0.0] - 2022-03-18
### Description
- EKS cluster initial code
- Cluster only example
- Cluster logging

[Unreleased]: https://github.com/boldlink/terraform-aws-eks/compare/3.3.2..HEAD

[3.3.2]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.3.2
[3.3.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.3.1
[3.3.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.3.0
[3.2.3]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.2.3
[3.2.2]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.2.2
[3.2.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.2.1
[3.2.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.2.0
[3.1.3]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.1.3
[3.1.2]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.1.2
[3.1.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.1.1
[3.1.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.1.0
[3.0.2]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.2
[3.0.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.1
[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0
[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0
[2.1.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.1
[2.1.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.0
[2.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.0.0
[1.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/1.0.0

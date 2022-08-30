# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- fix: Ensure all dynamic options both on module and submodules are present in the complete example.
- fix: CKV_AWS_37: "Ensure Amazon EKS control plane logging enabled for all log types
- fix: CKV_AWS_39: "Ensure Amazon EKS public endpoint disabled"
- fix: CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
- fix: Use only one KMS key per module for secrets cloudwatch, and ebs.
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

## [3.0.2] - 2022-08-30
fix: reference node iam arns inside the module for aws-auth configmap.

## [3.0.1] - 2022-08-26
### Description
- fix: aws-auth configmap usage; ability to either create a new one for self-managed node groups or modify an existing one.

## [3.0.0] - 2022-07-27
### Description
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

[Unreleased]: https://github.com/boldlink/terraform-aws-eks/compare/3.0.1...HEAD

[3.0.2]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.2

[3.0.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.1

[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0

[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0

[2.1.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.1

[2.1.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.0

[2.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.0.0

[1.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/1.0.0

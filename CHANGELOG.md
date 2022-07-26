# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- fix: Ensure all dynamic options in module and submodules are present on the complete example.
- fix: Configmap aws-auth doesn't allow adding additional users/groups/roles access beisides the nodes.
- fix: When you specify an external kms key to the cloudwatch log group you get an error, possibly because you need two variables.
- fix: CKV_AWS_37: "Ensure Amazon EKS control plane logging enabled for all log types
- fix: Use only one KMS key per module for secrets cloudwatch, and ebs.
- feat: Add gp3 kms encryption for ebs volumes attached on the managed and self managed node groups.
- feat: Add self-managed node-group for fully customizable cluster deployments, [for example windows node groups.](https://github.com/aws/containers-roadmap/issues/584).
- feat: Add EKS vpc-cni add on to the module with the iam role and service account IAM permissions (optional with true/false choice).
- feat: Add EKS ebs-csi add-on and the gp3 with encryption storageClass and service account IAM permissions (optional with true/false choice).
- feat: Add EKS CoreDNS add-on Kube-proxy (optional with true/false choice).
- feat: Add EKS ADOT Operator add-on and service account IAM permissions (optional with true/false choice).
- feat: Add a default managed node group with documented default values that gets created if var.enable_managed_node_group = true and var.managed_node_groups = {} (use less code to create a operational eks cluster).
- feat: Make all values of the tls_key variables not hardcoded values.
- feat: Add the capacity for additional policies or override default attached policies to both the cluster and node group iam roles.

## [3.0.0] - 2022-07-14
### Description
 - fix: Change the name of iam roles to prevent name conflict in the managed and fargate sub-modules.
 - fix: Add missing variables options on node groups provisioning.
 - fix: Make var.cluster_name mandatory for node_groups.
 - feat: Change how the node groups are provisined to enable you the option to add many different node groups.
 - feat: Change the variable name that enable managed and fargate node groups creation.
 - feat: Set the node_group key_pair creation by default to false.
 - feat: Change the node_group max_size to 3 and add a recomendation to the variable.
 - feat: Make the var.node_group_subnet_ids manadatory.
 - feat: Simplify how values are assigned to the node_group.
 - feat: Update the examples.
 - feat: Add irsa support with true/false option.
 - feat: Set managed node group var.ami_type to BOTTLEROCKET_x86_64.
 - feat: Ensure role names are unique and are limited to the 64 characters long.
 - feat: Change CIDR block and subnet ranges for vpc in the complete example stack.
 - feat: Add private subnets for the VPC of the complete example to support fargate node groups.
 - feat: Envelop kms key policy with jsonencode() function
 - feat: Add .checkov.yml to skip CKV_AWS_37 alert.
 - feat: Add supporting resources (vpc; kms) to be built once and used by all examples to minimize resource duplication during testing.
 - feat: Add supprting resources to makefile
 - feat: Move tags to locals.tf
 - feat: Add the SECURITY.md file
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

[Unreleased]: https://github.com/boldlink/terraform-aws-eks/compare/3.0.0...HEAD

[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0

[3.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/3.0.0

[2.1.1]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.1

[2.1.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.1.0

[2.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/2.0.0

[1.0.0]: https://github.com/boldlink/terraform-aws-eks/releases/tag/1.0.0

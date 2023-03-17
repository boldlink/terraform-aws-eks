### Eks node group
resource "aws_eks_node_group" "main" {
  cluster_name           = var.cluster_name
  node_role_arn          = aws_iam_role.node_group.arn
  subnet_ids             = var.node_group_subnet_ids
  ami_type               = var.ami_type
  capacity_type          = var.capacity_type
  disk_size              = var.disk_size
  force_update_version   = var.force_update_version
  instance_types         = var.instance_types
  labels                 = var.labels
  node_group_name        = var.node_group_name_prefix != null ? null : coalesce(var.node_group_name, var.cluster_name)
  node_group_name_prefix = var.node_group_name != null ? null : var.node_group_name_prefix
  release_version        = var.release_version
  tags                   = var.tags
  version                = var.kubernetes_version

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  dynamic "update_config" {
    for_each = var.update_config
    content {
      max_unavailable            = lookup(update_config.value, "max_unavailable", null)
      max_unavailable_percentage = lookup(update_config.value, "max_unavailable_percentage", null)
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id      = launch_template.value.name != null ? null : lookup(launch_template.value, "id", null)
      name    = launch_template.value.id != null ? null : lookup(launch_template.value, "name", null)
      version = launch_template.value.version
    }
  }

  dynamic "remote_access" {
    for_each = var.remote_access
    content {
      #ec2_ssh_key = lookup(remote_access.value, "ec2_ssh_key", null)
      ec2_ssh_key               = var.create_key_pair ? aws_key_pair.this[0].key_name : lookup(remote_access.value, "ec2_ssh_key", null)
      source_security_group_ids = lookup(remote_access.value, "source_security_group_ids", [])
    }
  }

  dynamic "taint" {
    for_each = var.taint
    content {
      key    = taint.value.key
      value  = lookup(taint.value, "value", null)
      effect = taint.value.effect
    }
  }

  timeouts {
    create = lookup(var.timeouts, "create", "60m")
    update = lookup(var.timeouts, "update", "60m")
    delete = lookup(var.timeouts, "delete", "60m")
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

### Key pair
resource "tls_private_key" "this" {
  count     = var.create_key_pair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = "${var.cluster_name}-keypair"
  public_key = tls_private_key.this[0].public_key_openssh
}

## For downloading the keypair to local computer
resource "null_resource" "local_save_ec2_keypair" {
  count = var.create_key_pair ? 1 : 0
  provisioner "local-exec" {
    command = "echo '${tls_private_key.this[0].private_key_pem}' > ${path.module}/${aws_key_pair.this[0].id}.pem"
  }
}

## AWS IAM Roles for the Node Groups
resource "aws_iam_role" "node_group" {
  name = substr("${var.cluster_name}-${var.node_group_name}-node-group-role", 0, 64)
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

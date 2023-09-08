data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  # Cloud-config configuration for installing ssm agent.
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/userdata.sh", {})
  }

  # Additional script
  part {
    content_type = "text/x-shellscript"
    content      = var.extra_script
  }
}

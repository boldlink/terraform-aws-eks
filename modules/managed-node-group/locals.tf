locals {
  launch_template_id      = var.create_custom_launch_template ? try(aws_launch_template.main[0].id, null) : var.launch_template_id
  launch_template_version = coalesce(var.launch_template_version, try(aws_launch_template.main[0].default_version, "$Default"))
}

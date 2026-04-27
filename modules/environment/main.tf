resource "local_file" "config" {
  filename = "configs/environments/${var.env_name}.txt"
  content = "Environment: ${var.env_name}\nDomain: ${var.domain}"
}
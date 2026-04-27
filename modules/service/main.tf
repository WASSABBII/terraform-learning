resource "local_file" "config" {
  filename = "configs/services/${var.service_name}.txt"
  content = "Service: ${var.service_name}\nEnvironment: ${var.environment}\nPort: ${var.port}"
}
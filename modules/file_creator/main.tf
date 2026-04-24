resource "local_file" "this" {
  filename = "${var.app_name}.txt"
  content = "App: ${var.app_name}\nEnvironment: ${var.environment}"
}
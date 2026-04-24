terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.0"
    }
  }
}

variable "app_name" {
    default = "my-app"   
}
variable "environment" {
  default = "development"
}

resource "local_file" "config" {
  filename = "config.txt"
  content = "App: ${var.app_name}\nEnvironment: ${var.environment}"
}

output "filename" {
  value = local_file.config.filename
}
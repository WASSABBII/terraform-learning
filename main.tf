terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

module "backend" {
  source      = "./modules/file_creator"
  app_name    = "backend"
  environment = "production"
}
module "frontend" {
  source      = "./modules/file_creator"
  app_name    = "frontend"
  environment = "production"
}
module "database" {
  source      = "./modules/file_creator"
  app_name    = "database"
  environment = "staging"
}
resource "local_file" "server" {
  count    = 3
  filename = "server-${count.index}.txt"
  content  = "server number: ${count.index}"
}
resource "local_file" "Gorod" {
  for_each = toset(["almaty", "shymkent", "astana"])
  filename = "${each.key}.txt"
  content  = "City: ${each.key}"
}

resource "local_file" "database" {
  filename   = "postgres.txt"
  content    = "database config"
  depends_on = [local_file.data]
}
resource "local_file" "data" {
  filename = "redis.txt"
  content  = "data config"
}
resource "local_file" "backend" {
  filename   = "backend.txt"
  content    = "backend config"
  depends_on = [local_file.data, local_file.database]
}
resource "local_file" "frontend" {
  filename   = "frontend.txt"
  content    = "Frontend"
  depends_on = [local_file.data, local_file.database, local_file.backend]
}

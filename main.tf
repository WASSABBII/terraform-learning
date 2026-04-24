terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.0"
    }
  }
}

module "backend" {
  source = "./modules/file_creator"
  app_name = "backend"
  environment = "production"
}
module "frontend" {
  source = "./modules/file_creator"
  app_name = "frontend"
  environment = "production"
}
module "database" {
  source   = "./modules/file_creator"
  app_name = "database"
  environment = "staging"
}
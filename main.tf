terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

module "postgres" {
  source       = "./modules/service"
  service_name = "postgres"
  port         = 5432
  environment  = "production"
  depends_on = [ module.redis ]
}
module "redis" {
  source       = "./modules/service"
  service_name = "redis"
  port         = 6379
  environment  = "production"
}
module "backend" {
  source       = "./modules/service"
  service_name = "Backend"
  port         = 8080
  environment  = "production"
  depends_on = [ module.postgres , module.redis ]
}
module "frontend" {
  source       = "./modules/service"
  service_name = "Frontend"
  port         = 3000
  environment  = "production"  
  depends_on = [ module.redis , module.postgres , module.backend ]
}
module "production" {
  source       = "./modules/environment"
  env_name = "production"
  domain = "dastarhan.kz"
}
module "staging" {
  source = "./modules/environment"
  env_name = "staging"
  domain = "staging.dastarhan.kz"
}
resource "local_file" "servers" {
  count = 3
  filename = "configs/servers/server-${count.index}.txt"
  content = "Server:${count.index}"
}
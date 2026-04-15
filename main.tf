resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project = "auto-healing-web"
    env     = "dev"
  }
}

module "network" {
  source = "./modules/network"
  prefix = var.prefix
  location = var.location
  rg_name = azurerm_resource_group.rg.name
}

module "lb" {
    source = "./modules/loadbalancer"
    prefix = var.prefix
    location = var.location
    rg_name = azurerm_resource_group.rg.name  
}

module "vmss" {
  source = "./modules/vmss"
  prefix = var.prefix
  location = var.location
  rg_name = azurerm_resource_group.rg.name
  subnet_id = module.network.subnet_id
  backend_pool_id = module.lb.backend_pool_id
  ssh_key = var.ssh_public_key
}
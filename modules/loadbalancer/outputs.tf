output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.bepool.id
}

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}
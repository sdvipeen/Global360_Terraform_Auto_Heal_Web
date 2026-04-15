output "public_ip" {
  value = module.lb.backend_pool_id
}
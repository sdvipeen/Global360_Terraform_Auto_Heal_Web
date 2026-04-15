variable "location" {
  default = "Australia Southeast"
}

variable "resource_group_name" {
  default = "rg-autoheal-web-dev"
}

variable "prefix" {
  default = "autoheal"
}

variable "ssh_public_key" {
  description = "SSH public key for VMSS admin user"
  type        = string
  sensitive   = true
}
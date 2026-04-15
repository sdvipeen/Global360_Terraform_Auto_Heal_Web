resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.prefix}-vmss"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard_B1s"
  instances           = 2
  admin_username      = "global360azureuser"
  
  #admin_password = "Password1234!"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "global360azureuser"
    public_key = var.ssh_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = [ 
        var.backend_pool_id
       ]
    }
  }

  custom_data = base64encode(file("${path.module}/cloud-init.sh"))

  upgrade_mode = "Automatic"
}
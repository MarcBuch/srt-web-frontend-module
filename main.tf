resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "${var.prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.region
  sku                 = var.vm_size
  instances           = 2
  admin_username      = "adminuser"

  network_interface {
    name    = "${var.prefix}-vmss-nic"
    primary = true

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = var.subnet_id
      application_gateway_backend_address_pool_ids = [var.application_gateway_backend_pool_id]
    }
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.ssh_key_file)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }
}

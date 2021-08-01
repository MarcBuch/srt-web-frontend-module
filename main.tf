resource "azurerm_network_interface" "this" {
  name                = "${var.prefix}-vm00-nic0"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

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
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
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

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "this" {
  network_interface_id    = azurerm_network_interface.this.id
  ip_configuration_name   = azurerm_network_interface.this.ip_configuration[0].name
  backend_address_pool_id = var.application_gateway_backend_pool_id
}

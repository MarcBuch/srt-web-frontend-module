variable "tenant_id" {
  description = "The tenant ID used for the azurerm provider"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID used for the azurerm provider"
  type        = string
}

variable "prefix" {
  description = "Naming prefix to add to all resource names"
  type        = string
}

variable "region" {
  description = "Azure region to deploy to"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to deploy to"
  type        = string
}

variable "subnet_id" {
  description = "Subnet for the VMs"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_key_file" {
  description = "Location for the ssh key to add"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "image" {
  description = "VM image"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

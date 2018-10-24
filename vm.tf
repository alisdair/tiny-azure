resource "azurerm_virtual_machine" "tiny" {
  name                  = "tiny-vm"
  location              = "${azurerm_resource_group.network.location}"
  resource_group_name   = "${azurerm_resource_group.network.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "B1S"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

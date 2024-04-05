resource "azurerm_linux_virtual_machine" "Ubuntu-Porcionato" {
  name                = "Ubuntu-Porcionato"
  resource_group_name = azurerm_resource_group.grupo.name
  location            = azurerm_resource_group.grupo.location
  size                = "Standard_DS1_v2"
  disable_password_authentication = false

  admin_username = "adminuser"
  admin_password = "Senai@134@134"

  network_interface_ids = [
    azurerm_network_interface.rede.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
}
resource "azurerm_virtual_machine_extension" "bootstrap-Ubuntu" {
  name                 = "bootstrap-Ubuntu"
  virtual_machine_id   = azurerm_linux_virtual_machine.Ubuntu-Porcionato.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": ["./site-ubuntu.sh"],
        "commandToExecute": "bash site-ubuntu.sh"
    }
SETTINGS
}
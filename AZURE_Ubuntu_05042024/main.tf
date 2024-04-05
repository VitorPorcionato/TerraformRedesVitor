provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "grupo" {
  name     = "Ubuntu-Vitor"
  location = "East US"
}

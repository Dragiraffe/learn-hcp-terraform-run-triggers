output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet1.id
}

output "azurerm_network_security_group_id" {
  value = azurerm_network_security_group.rg.id
}

output "organization_name" {
  value = var.organization_name
}


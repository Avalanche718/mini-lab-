output "logic_app_name" {
  description = "Name of the Logic App Standard"
  value       = azurerm_logic_app_standard.logic.name
}

output "integration_account_name" {
  description = "Name of the Integration Account"
  value       = azurerm_integration_account.ia.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

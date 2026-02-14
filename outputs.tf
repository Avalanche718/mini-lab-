output "logic_app_name" {
  value = azurerm_logic_app_standard.logic.name
}

output "integration_account_name" {
  value = azurerm_integration_account.ia.name
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_service_plan" "plan" {
  name                = local.service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"   # Required!
  sku_name            = "WS1"       # Workflow Standard SKU
}

resource "azurerm_logic_app_standard" "logic" {
  name                       = local.logic_app_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key   # Required by provider

  identity {
    type = "SystemAssigned"   # Lab requirement: enabled
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }

  depends_on = [azurerm_storage_account.sa]
}

resource "azurerm_integration_account" "ia" {
  name                = local.integration_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "Standard"
}

resource "azurerm_integration_account_schema" "schema" {
  name                     = "healthcare-message.xsd"
  resource_group_name      = azurerm_resource_group.rg.name
  integration_account_name = azurerm_integration_account.ia.name
content = file("${path.module}/schemas/healthcare-message.xsd")  # Fix here

  depends_on = [azurerm_integration_account.ia]
}

# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

# 2. Storage Account (must be StorageV2, Files enabled implicitly)
resource "azurerm_storage_account" "sa" {
  name                     = "${var.prefix}sa"          # must be globally unique → 3-24 chars, lowercase
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}

# 3. App Service Plan – Workflow Standard SKU (WS1 = smallest)
resource "azurerm_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"           # Required for Logic App Standard
  sku_name            = "WS1"               # WorkflowStandard tier
}

# 4. Logic App Standard
resource "azurerm_logic_app_standard" "logic" {
  name                       = "${var.prefix}-logic"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key   # Required by Terraform provider

  identity {
    type = "SystemAssigned"   # Enables managed identity (lab requirement)
  }

  # Minimal app settings (runtime)
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }

  depends_on = [azurerm_storage_account.sa]
}

# 5. Integration Account – Standard SKU
resource "azurerm_integration_account" "ia" {
  name                = "${var.prefix}-ia"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "Standard"
}

# 6. Upload sample XML Schema
resource "azurerm_integration_account_schema" "schema" {
  name                     = "healthcare-message.xsd"
  resource_group_name      = azurerm_resource_group.rg.name
  integration_account_name = azurerm_integration_account.ia.name
  content                  = file("${path.module}/schemas/sample_schema.xsd")
}

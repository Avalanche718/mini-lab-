terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"   # or ">= 3.0, < 4.0" — stable in 2025/2026
    }
  }
}

provider "azurerm" {
  features {}
}

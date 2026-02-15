terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"   # or ">= 3.100.0" — works in 2026
    }
  }
}

provider "azurerm" {
  features {}
}

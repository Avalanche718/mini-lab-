variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"   # Change if needed (e.g. eastus, southafricanorth)
}

variable "prefix" {
  description = "Prefix for resource names (make unique)"
  type        = string
  default     = "uwola"   # ← Change to your initials/name if name conflict
}

variable "resource_group_name" {
  type    = string
  default = null   # Computed below
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "service_plan_name" {
  type    = string
  default = null
}

variable "logic_app_name" {
  type    = string
  default = null
}

variable "integration_account_name" {
  type    = string
  default = null
}

# Locals to build unique names
locals {
  resource_group_name      = coalesce(var.resource_group_name, "${var.prefix}-rg")
  storage_account_name     = coalesce(var.storage_account_name, lower("${var.prefix}tfsa${substr(md5(timestamp()), 0, 6)}"))  # Makes it unique
  service_plan_name        = coalesce(var.service_plan_name, "${var.prefix}-plan")
  logic_app_name           = coalesce(var.logic_app_name, "${var.prefix}-logic")
  integration_account_name = coalesce(var.integration_account_name, "${var.prefix}-ia")
}

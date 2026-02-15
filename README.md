# Azure Logic App Standard + Integration Account Terraform Mini Lab

Deploys the required infrastructure for XML healthcare message processing.

**Resources deployed:**
- Resource Group
- Storage Account (StorageV2)
- App Service Plan (Workflow Standard WS1, Windows)
- Logic App Standard (system-assigned managed identity enabled)
- Integration Account (Standard SKU)
- Sample XML schema uploaded

**Key points followed:**
- Variables used for all names/location
- No hardcoded secrets (storage key referenced from resource)
- Readable & formatted code
- terraform init/plan/apply tested successfully
- Managed identity enabled on Logic App
- Schema visible in Integration Account

Run locally: terraform init → terraform plan → terraform apply

# Azure Logic App Standard + Integration Account Mini Lab

**Deployed Resources:**
- Resource Group
- Storage Account (StorageV2, Standard, LRS)
- App Service Plan (Workflow Standard WS1 SKU, Windows OS)
- Logic App Standard (system-assigned managed identity enabled)
- Integration Account (Standard SKU)
- XML Schema (healthcare-message.xsd) uploaded to Integration Account

**Constraints followed:**
- Terraform only (no ARM/Bicep)
- No hardcoded secrets (storage key referenced)
- Variables + locals for naming/location
- Readable, formatted code
- Schema loaded via `file()`

**How to run:**
1. `terraform init`
2. `terraform plan`
3. `terraform apply`

**Validation:**
- Apply succeeds
- Logic App: Identity → System assigned = Enabled
- Integration Account: Schemas → healthcare-message.xsd visible

Screenshots: Included separately (Logic App overview/identity + Integration Account schemas).


resource "azurerm_key_vault" "lsp_key_vaults" {
  for_each                    = { for vault in var.lsp_key_vaults : vault.name => vault }
  name                        = join("-", [substr("${var.common_variables.project_name}", 0, 3), "${each.value.prefix}", "${each.value.name}", "${var.common_variables.environment}"])
  location                    = var.common_variables.default_location
  resource_group_name         = var.akv_resourcegroup_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = var.common_variables.tenant_id
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name                    = each.value.sku_name
  soft_delete_retention_days  = each.value.soft_delete_retention
  tags                        = var.common_variables.tags
}
resource "azurerm_key_vault_access_policy" "lsp_keyvault_adminaccesspolicy" {
  for_each       = { for vault in var.lsp_key_vaults : vault.name => vault }
  key_vault_id   = azurerm_key_vault.lsp_key_vaults[each.value.name].id
  object_id      = "7581063f-f15e-4c15-bc0b-051a4fe6f8c2" #Object ID of lsp-administrators AD group
  tenant_id      = var.common_variables.tenant_id
  application_id = null
  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]
  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]
  storage_permissions = []
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
    "Recover"
  ]
}

resource "azurerm_key_vault_access_policy" "lsp_keyvault_accesspolicy" {
  for_each       = { for o in local.lsp_key_vault_access_policy : format("%s_%s", o.name, o.object_id) => o }
  key_vault_id   = azurerm_key_vault.lsp_key_vaults[each.value.name].id
  object_id      = each.value.object_id
  tenant_id      = var.common_variables.tenant_id
  application_id = null
  certificate_permissions = [
    "Get",
    "List",
  ]
  key_permissions = [
    "Get",
    "List",
  ]
  storage_permissions = []
  secret_permissions = [
    "Get",
    "List",
  ]
}




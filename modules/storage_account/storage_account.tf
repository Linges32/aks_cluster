resource "azurerm_storage_account" "lsp_storage_account" {
  for_each                   = { for account in var.lsp_storage_account : account.name => account }
  name                       = lower(replace("sa${var.common_variables.project_name}${each.key}${var.common_variables.environment}", "/[[:^alnum:]]/", ""))
  resource_group_name        = var.sa_resourcegroup_name
  location                   = var.common_variables.default_location
  account_tier               = each.value.account_tier
  account_kind               = each.value.account_kind
  https_traffic_only_enabled = "true"
  account_replication_type   = each.value.account_replication_type
  blob_properties {
    delete_retention_policy {
      days = each.value.soft_delete_retention
    }
  }
  tags = var.common_variables.tags
}
resource "azurerm_role_assignment" "lsp_storage_account_role_assignment" {
  for_each             = { for o in local.lsp_storage_account_access_policy : format("%s_%s", o.name, o.object_id) => o }
  scope                = azurerm_storage_account.lsp_storage_account[each.value.name].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value.object_id
}

resource "azurerm_storage_management_policy" "lsp_storage_account_policy" {
  for_each           = { for account in var.lsp_storage_account : account.name => account }
  storage_account_id = azurerm_storage_account.lsp_storage_account[each.key].id
  rule {
    name    = each.value.policy_name
    enabled = each.value.policy_enabled
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = each.value.policy_numberofdays
      }
    }
  }
}

resource "azurerm_storage_container" "lsp_storage_account_container" {
  depends_on         = [azurerm_storage_account.lsp_storage_account]
  for_each           = { for x in local.lsp_storage_account_container : format("%s_%s_%s", x.name, x.container_name, x.env_name) => x }
  name               = "${each.value.container_name}-${each.value.env_name}"
  storage_account_id = azurerm_storage_account.lsp_storage_account[each.value.name].id
  # storage_account_name  = lower(replace("sa${var.common_variables.project_name}${each.value.name}${var.common_variables.environment}", "/[[:^alnum:]]/", ""))
  container_access_type = each.value.access_type
}


variable "akv_resourcegroup_name" {
  description = "value of the key vault resource group name"
  type        = string
}
variable "common_variables" {
  description = "value of the common variables"
}

variable "lsp_key_vaults" {
  description = "values for key vaults"
  type = list(object({
    access_policy = list(object({
      object_id = string
    }))
    account_kind                = string
    account_replication_type    = string
    account_tier                = string
    enabled_for_disk_encryption = bool
    name                        = string
    prefix                      = string
    purge_protection_enabled    = bool
    sku_name                    = string
    soft_delete_retention       = string
  }))
}

locals {

  lsp_key_vault_access_policy = flatten([
    for a in var.lsp_key_vaults : [
      for b in a.access_policy : [
        {
          name      = a.name
          object_id = b.object_id
        }
      ]
    ]
  ])

}

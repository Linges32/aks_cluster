variable "sa_resourcegroup_name" {
  description = "value of the storage account resource group name"
  type        = string
}
variable "common_variables" {
  description = "value of the common variables"
}
variable "lsp_storage_account" {
  description = "Configuration Values for Storage Account and Containers"
  type = list(object({
    access_policy = list(object({
      object_id = string
    }))
    access_type              = string
    account_kind             = string
    account_replication_type = string
    account_tier             = string
    container_config = list(object({
      container_name = string
      env_suffix = list(object({
        env_name = string
      }))
    }))
    name                  = string
    policy_enabled        = string
    policy_name           = string
    policy_numberofdays   = number
    soft_delete_retention = string
  }))
}

locals {
  lsp_storage_account_container = flatten([
    for a in var.lsp_storage_account : [
      for b in a.container_config : [
        for c in b.env_suffix : [
          {
            name           = a.name,
            access_type    = a.access_type,
            container_name = b.container_name,
            env_name       = c.env_name
  }]]]])

  lsp_storage_account_access_policy = flatten([
    for a in var.lsp_storage_account : [
      for b in a.access_policy : [
        {
          name      = a.name
          object_id = b.object_id
        }
      ]
    ]
  ])
}

variable "dfc_vtm_resource_groups" {
  description = "Name Token of the Resource Group. Final Format rg-dfc_vtm-<name>-<env>"
  type = list(object({
    name = string
  }))
  default = []
}
variable "dfc_vtm_aks" {
  description = "Configuration values for the AKS cluster to pass to the main module."
  type = object({
    name                            = string
    kubernetes_version              = string
    sku_tier                        = string
    rbac_aad_admin_group_object_ids = list(string)
    availability_zones              = list(number)
    node_max_pods                   = string
    os_disk_size_gb                 = string
    vnet_subnet_id                  = string
    node_pool_name                  = string
    node_pool_node_count            = string
    node_pool_min_count             = string
    node_pool_max_count             = string
  })
}
variable "common_tags" {
  description = "A mapping of tags to assign to each resource"
  type = object({
    keys   = list(string)
    values = list(string)
  })
}
variable "environment" {
  description = "Name of the Environment"
  type        = string
  default     = "devtst"
}
variable "default_location" {
  description = "Azure Region in which the resource to be deployed"
  type        = string
  default     = "northeurope"
}
variable "project_name" {
  description = "Project name Identifier"
  type        = string
  default     = "dfc_vtm"
}

variable "tenant_id" {
  description = "Tenant ID of the Azure Subscription being used"
  type        = string
  default     = "e11fd634-26b5-47f4-8b8c-908e466e9bdf"
}

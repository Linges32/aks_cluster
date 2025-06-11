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
variable "aks_resourcegroup_name" {
  description = "The name of the resource group where the AKS cluster will be deployed."
  type        = string
}
variable "common_variables" {
  description = "Common variables to be used in the module."
}

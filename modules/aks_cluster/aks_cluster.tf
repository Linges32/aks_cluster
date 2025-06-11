# This module in turn calls the Azure Platform Team's Terraform module. To create AKS cluster, person running this terraform will need to activate Role: js_aks_contributor via - https://front-door.azurelz.js-devops.co.uk/MyUserAccess
module "aks_cluster" {
  auth_type                        = "msi"
  enable_role_based_access_control = "true"
  enable_auto_scaling              = "true"
  existing_resource_group          = "true"
  kubernetes_version               = var.dfc_vtm_aks["kubernetes_version"]
  LandingZone_Version              = "LZ2"
  location                         = "North Europe"
  name                             = var.dfc_vtm_aks["name"]
  node_count                       = "1"
  node_pool_name                   = "system"
  node_max_pods                    = var.dfc_vtm_aks["node_max_pods"]
  node_max_count                   = "3"
  node_min_count                   = "1"
  node_size                        = "Standard_D2_v3"
  only_critical_addons_enabled     = "true"
  os_disk_size_gb                  = var.dfc_vtm_aks["os_disk_size_gb"] #"100"
  private_cluster_enabled          = "true"
  rbac_aad_admin_group_object_ids  = var.dfc_vtm_aks["rbac_aad_admin_group_object_ids"]
  resource_group_name              = var.aks_resourcegroup_name
  sku_tier                         = var.dfc_vtm_aks["sku_tier"]
  source                           = "git@github.com:JSainsburyPLC/jsapt-terraform-module-aks.git?ref=v2.2.1"
  tags                             = var.common_variables.tags
  vnet_subnet_id                   = var.dfc_vtm_aks["vnet_subnet_id"]
  network_profile = {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
  additional_node_pools = [
    {
      name                 = var.dfc_vtm_aks["node_pool_name"]
      priority             = "Regular"
      vnet_subnet_id       = var.dfc_vtm_aks["vnet_subnet_id"]
      tags                 = var.common_variables.tags
      enable_auto_scaling  = true
      availability_zones   = var.dfc_vtm_aks["availability_zones"] #[1, 2, 3]
      orchestrator_version = var.dfc_vtm_aks["kubernetes_version"]
      max_pods             = "110"
      os_disk_size_gb      = "128"
      sku_tier             = "Free"
      vm_size              = "Standard_D2_v3"
      node_count           = var.dfc_vtm_aks["node_pool_node_count"]
      min_count            = var.dfc_vtm_aks["node_pool_min_count"]
      max_count            = var.dfc_vtm_aks["node_pool_max_count"]
      node_labels          = {}
      node_taints          = []
    }
  ]
}

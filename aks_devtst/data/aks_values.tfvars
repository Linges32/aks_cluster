dfc_vtm_aks = {
  name                            = "dfc-vtm-test-aks"
  kubernetes_version              = "1.32.4"
  sku_tier                        = "Free"
  vnet_subnet_id                  = "/subscriptions/bb869038-a427-4685-9703-fdc2edf8a946/resourceGroups/rg-vtmcnp-nprd-network/providers/Microsoft.Network/virtualNetworks/vnet-vtmcnp-nprd-network/subnets/snet-vtmcnp-nprd-02"
  node_pool_name                  = "dfc-app1-AKS"
  node_pool_node_count            = "3"
  node_pool_min_count             = "1"
  node_pool_max_count             = "5"
  node_max_pods                   = "100"
  os_disk_size_gb                 = "50"
  availability_zones              = [1, 2, 3]
  rbac_aad_admin_group_object_ids = ["518cfd89-00f0-48c1-a1a7-148d4d1b2f53","ed2b9045-590d-49cc-a6df-0e3da2b3b2bf"] # VTM-dfc_plan_admin-role & Joshua Adedokun AD group & Name object ID 

}

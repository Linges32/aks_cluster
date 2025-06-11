resource "azurerm_user_assigned_identity" "lsp_managed_identity" {
  for_each            = { for id in var.lsp_managed_identity : id.name => id }
  name                = "${var.common_variables.project_name}-${each.value.name}-${var.common_variables.environment}"
  location            = var.common_variables.default_location
  resource_group_name = var.msi_resourcegroup_name
  tags                = var.common_variables.tags
}


resource "azurerm_federated_identity_credential" "lsp_msi_federation_id" {
  for_each            = { for id in local.lsp_msi_federation_id : format("%s_%s", id.name, id.env_name) => id }
  name                = "${var.common_variables.project_name}-${each.value.name}-fed-${each.value.env_name}"
  resource_group_name = var.msi_resourcegroup_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = each.value.env_name == "dev" || each.value.env_name == "tst" ? var.devtst_aks_issuer_url : each.value.env_name == "vnp" ? var.vnp_aks_issuer_url : each.value.env_name == "ppt" || each.value.env_name == "uat" ? var.preprd_aks_issuer_url : var.prod_aks_issuer_url
  parent_id           = azurerm_user_assigned_identity.lsp_managed_identity[each.value.name].id
  subject             = "system:serviceaccount:lsp-${each.value.env_name}:lsp-${each.value.name}-${each.value.env_name}"
}

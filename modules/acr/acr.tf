resource "azurerm_container_registry" "acr" {
  name                = "${var.common_variables.project_name}acr${var.common_variables.environment}"
  resource_group_name = var.acr_resourcegroup_name
  location            = var.common_variables.default_location
  sku                 = var.lsp_acr["sku"]
  admin_enabled       = var.lsp_acr["admin_enabled"]
  network_rule_set    = []
  tags                = var.common_variables.tags
}

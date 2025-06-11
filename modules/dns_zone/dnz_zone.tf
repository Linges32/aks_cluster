# resource "azurerm_dns_zone" "default" {
#   name                = module.lsp_variables.lsp_dns_zone_name
#   resource_group_name = var.dns_resourcegroup_name
#   tags                = module.lsp_variables.common_tags_processed
# }
# resource "azurerm_dns_zone" "lsp_azure_dns_zone_name" {
#   name                = module.lsp_variables.lsp_azure_dns_zone_name
#   resource_group_name = var.dns_resourcegroup_name
#   tags                = module.lsp_variables.common_tags_processed
# }


resource "azurerm_api_management" "lsp_apim_v2" {
  for_each = { for apim in var.lsp_apim_v2 : apim.name => apim }

  name                 = "${var.common_variables.project_name}-${each.value.name}-${var.common_variables.environment}"
  location             = var.common_variables.default_location
  resource_group_name  = var.apim_resourcegroup_name
  publisher_name       = each.value.organisation
  publisher_email      = each.value.admin_email
  sku_name             = "${each.value.sku_name}_${each.value.sku_capacity}"
  public_ip_address_id = var.lsp_apim_v2_publicIP
  virtual_network_type = each.value.virtual_network_type
  virtual_network_configuration {
    subnet_id = each.value.vnet_subnet_id
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.common_variables.tags
}


resource "azurerm_api_management_api" "lsp_apim_v2_api" {
  depends_on = [
    azurerm_api_management.lsp_apim_v2
  ]
  for_each              = { for x in local.lsp_apim_v2_api : x.api_name => x }
  name                  = each.value.api_name
  resource_group_name   = var.apim_resourcegroup_name
  api_management_name   = azurerm_api_management.lsp_apim_v2[each.value.name].name
  revision              = each.value.revision
  display_name          = each.value.display_name
  path                  = each.value.path
  protocols             = each.value.protocols
  service_url           = each.value.service_url
  subscription_required = coalesce(each.value.subscription_required, true)
}

resource "azurerm_api_management_api_operation" "lsp_api_operations" {
  depends_on = [
    azurerm_api_management_api.lsp_apim_v2_api
  ]
  for_each            = { for x in local.lsp_apim_v2_api_operations : format("%s_%s", x.api_name, x.operation_id) => x }
  operation_id        = each.value.operation_id
  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.lsp_apim_v2[each.value.name].name
  resource_group_name = var.apim_resourcegroup_name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = each.value.url_template

  dynamic "template_parameter" {
    for_each = each.value.template_block_required == "yes" ? [var.lsp_apim_v2_operation_ftgw_template_parameter] : []
    content {
      name     = template_parameter.value["template_name"]
      required = template_parameter.value["template_required"]
      type     = template_parameter.value["template_type"]
      values   = template_parameter.value["template_values"]
    }
  }
}

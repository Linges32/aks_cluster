output "lsp_resource_groups" {
  value = {
    for o in azurerm_resource_group.lsp_resource_groups :
    # substr(o.name, 7, 3) => o
    split("-", o.name)[2] => o
  }
  description = "value of the resource group"
}

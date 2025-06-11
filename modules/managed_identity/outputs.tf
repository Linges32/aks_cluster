output "msi_id" {
  value = {
    for msi_id in azurerm_user_assigned_identity.lsp_managed_identity :
    msi_id.id => msi_id
  }
  description = "output value of the managed identity"
}

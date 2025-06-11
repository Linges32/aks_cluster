output "kv_id" {
  value = {
    for kv_id in azurerm_key_vault.lsp_key_vaults :
    kv_id.name => kv_id
  }
  description = "value of the key vault id"
}

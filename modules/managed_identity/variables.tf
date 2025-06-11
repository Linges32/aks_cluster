
variable "common_variables" {
  description = "value of the common variables"
}
variable "msi_resourcegroup_name" {
  type        = string
  description = "value of the msi resource group name"
}
variable "devtst_aks_issuer_url" {
  type        = string
  description = "value of the OIDC issuer URL  of the AKS"
}
variable "preprd_aks_issuer_url" {
  type        = string
  description = "value of the OIDC issuer URL  of the AKS"
}
variable "vnp_aks_issuer_url" {
  type        = string
  description = "value of the OIDC issuer URL  of the AKS"
}
variable "prod_aks_issuer_url" {
  type        = string
  description = "value of the OIDC issuer URL  of the AKS"
}
variable "lsp_managed_identity" {
  type = list(object({
    name       = string
    federation = list(object({ env_name = string }))
  }))
  description = "name of the managed Identity"
}

locals {
  # lsp_msi_federation_id = flatten(var.lsp_managed_identity)
  lsp_msi_federation_id = flatten([
    for a in var.lsp_managed_identity : [
      for b in a.federation : [
        {
          name     = a.name,
          env_name = b.env_name
      }]
    ]
  ])
}


variable "acr_resourcegroup_name" {
  type        = string
  description = "value of the acr resource group name"
}
variable "common_variables" {
  description = "value of the common variables"
}

variable "lsp_acr" {
  description = "A mapping of values for creating a container registry"
  type = object({
    sku           = string
    admin_enabled = string
  })
  default = {
    sku           = "Basic"
    admin_enabled = "true"
  }

}



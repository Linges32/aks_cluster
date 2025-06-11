# NONPROD 
variable "apim_resourcegroup_name" {
  description = "value of the apim resource group name"
  type        = string
}
variable "common_variables" {
  description = "value of the common variables"
}
variable "lsp_apim_v2_publicIP" {
  description = "Configuration Values for the APIM resource"
  type        = string
}

variable "lsp_apim_v2" {
  description = "Configuration Values for the APIM resource"
  type = list(object({
    admin_email = string
    api_configs = list(object({
      api_name     = string
      display_name = string
      operations = list(object({
        method                  = string
        op_display_name         = string
        operation_id            = string
        template_block_required = string
        url_template            = string
      }))
      path_value            = string
      protocols             = list(string)
      revision              = string
      service_url           = string
      subscription_required = optional(bool)
    }))
    name                 = string
    organisation         = string
    sku_capacity         = number
    sku_name             = string
    virtual_network_type = string
    vnet_subnet_id       = string
  }))
}

variable "lsp_apim_v2_operation_ftgw_template_parameter" {
  description = "configuration values for the file transfer gateway template"
  type = object({
    template_name     = string
    template_required = string
    template_type     = string
    template_values   = list(string)
  })
  default = {
    template_name     = "interfaceId"
    template_required = "true"
    template_type     = "string"
    template_values   = []
  }
}

locals {
  lsp_apim_v2_api = flatten([
    for a in var.lsp_apim_v2 : [
      for b in a.api_configs : [
        {
          name                  = a.name
          api_name              = b.api_name,
          revision              = b.revision,
          display_name          = b.display_name,
          path                  = b.path_value,
          protocols             = b.protocols,
          service_url           = b.service_url,
          subscription_required = b.subscription_required
  }]]])

  lsp_apim_v2_api_operations = flatten([
    for a in var.lsp_apim_v2 : [
      for b in a.api_configs : [
        for c in b.operations : [
          {
            name                    = a.name
            api_name                = b.api_name
            operation_id            = c.operation_id
            display_name            = c.op_display_name
            method                  = c.method
            url_template            = c.url_template
            template_block_required = c.template_block_required

          }
        ]
      ]
    ]
  ])
}

variable "lsp_resource_groups" {
  description = "Name Token of the Resource Group. Final Format rg-lsp-<name>-<env>"
  type = list(object({
    name = string
  }))
  default = []
}
variable "common_variables" {
  description = "value of the common variables"
}

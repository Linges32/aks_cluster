
variable "common_tags" {
  description = "A mapping of tags to assign to each resource"
  type = object({
    keys   = list(string)
    values = list(string)
  })
  # default = {
  #   keys   = ["environment", "email", "costcentre", "live", "servicename", "dataRetention", "dataClassification"]
  #   values = ["nonprd", "archana.yadava@sainsburys.co.uk", "PD7748", "no", "logistics services platform", "4-years", "confidential"]
  # }
}

variable "environment" {
  description = "Name of the Environment"
  type        = string
  # default     = "nonprd"
}
variable "default_location" {
  description = "Azure Region in which the resource to be deployed"
  type        = string
  default     = "northeurope"
}
variable "project_name" {
  description = "Project name Identifier"
  type        = string
  default     = "lsp"
}

variable "tenant_id" {
  description = "Tenant ID of the Azure Subscription being used"
  type        = string
  default     = "e11fd634-26b5-47f4-8b8c-908e466e9bdf"
}

locals {
  common_tags_keys      = var.common_tags["keys"]
  common_tags_values    = var.common_tags["values"]
  common_tags_processed = zipmap(local.common_tags_keys, local.common_tags_values)
}

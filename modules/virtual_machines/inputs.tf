module "lsp_variables" {
  source      = "../../variables"
  environment = var.env_identifier
}

variable "env_identifier" {
  description = "Environment Identifier"
  type        = string
}


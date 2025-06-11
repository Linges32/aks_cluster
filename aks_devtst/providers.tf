# LSP_DEV PROVIDER FILES
provider "azurerm" {
  subscription_id = "bb869038-a427-4685-9703-fdc2edf8a946"
  tenant_id       = "e11fd634-26b5-47f4-8b8c-908e466e9bdf"
  features {
  }
}


terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dfc-nonprod-azure-vtm-cloudworkspace"
    storage_account_name = "vtmdefenderstorage"
    container_name       = "terraform-state-files"  #ask Aparna
    key                  = "js-lsp-azure-private-infra-dev.tfstate" #Ask Aparna
    subscription_id      = "bb869038-a427-4685-9703-fdc2edf8a946"
    tenant_id            = "e11fd634-26b5-47f4-8b8c-908e466e9bdf"
  }
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.6.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.71.0"
    }
  }
}

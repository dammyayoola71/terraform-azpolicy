terraform {
  backend "azurerm" {
    resource_group_name  = "Azure-storage-rg"
    storage_account_name = "damzterraformst"
    container_name       = "statefile"
    key                  = "terraform.tfstate"
  }
}

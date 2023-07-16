terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.90"
    }
  }
}

provider "azurerm" {
  features {}
}

module "az_policy_assignment" {
  source = "../../management_group_policy_assignment "
  policy_type                    = "policy_definition"
  policy_definition_display_name = "Deploy Diagnostic Settings for Virtual Network to Log Analytics workspace"
  assignment_name                = "deploy-vnet-diag"
  assignment_scope               = "/providers/Microsoft.Management/managementGroups/corp"
  enforce                        = false
  region                         = "westus2"
  non_compliance_message         = "Resource requires diagnostic settings to be enabled"

  metadata = <<METADATA
{
  "category": "Monitoring"
}
METADATA

  parameters = <<PARAMETERS
{  
  "logAnalytics": {
      "value": "/subscriptions/aa533ac5-66d7-4da8-bdd8-c2db663a71ab/resourcegroups/rg-example-vnet-sandbox/providers/microsoft.operationalinsights/workspaces/laws-dpatterson-sandbox"
  }
}
PARAMETERS

  not_scopes = [
    "/subscriptions/aa533ac5-66d7-4da8-bdd8-c2db663a71ab/resourceGroups/rg-ayxtfstate-sandbox"
  ]
}

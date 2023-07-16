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
  source = "../.."

  tenant_id = "522f39d9-303d-488f-9deb-a6d77f1eafd8"

  policy_type                    = "policy_set_definition"
  policy_definition_display_name = "Deploy Diagnostic Settings to Azure Services"
  assignment_name                = "deploy-resource-diag"
  assignment_scope               = "/providers/Microsoft.Management/managementGroups/ayxcloud"
  enforce                        = false
  identity                       = "SystemAssigned"
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
}

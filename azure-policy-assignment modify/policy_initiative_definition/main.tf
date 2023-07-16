locals {
  policy_definitions = [
    "/providers/Microsoft.Authorization/policyDefinitions/04d53d87-841c-4f23-8a5b-21564380b55e",
    "/providers/Microsoft.Authorization/policyDefinitions/1f6e93e8-6b31-41b1-83f6-36e449a42579",
    "/providers/Microsoft.Authorization/policyDefinitions/25763a0a-5783-4f14-969e-79d4933eb74b"    
 
  ]
  policy_definitions_without_logAnalytics = [
    "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d", # Example Policy Definition 4
    "/providers/Microsoft.Management/managementGroups/389b7e7c-4be2-4213-81b1-9e3a9afabd19/providers/Microsoft.Authorization/policyDefinitions/75980f4c-99b4-4f88-ac9d-0d587bc6576f",

  ]
}

resource "azurerm_policy_set_definition" "azdefinition-wl-eus-loganalytics" {

  name         = "azdefinition-wl-eus-loganalytics"
  policy_type  = "Custom"
  display_name = "Damitest initiative-mydeployment"
  description  = "Testing initiative deployment"
  management_group_id  = "/providers/Microsoft.Management/managementGroups/389b7e7c-4be2-4213-81b1-9e3a9afabd19"


  metadata = jsonencode(
    {
      "category" : "Monitoring"
  })

  parameters = jsonencode({
    "logAnalytics_name" : {
      "type" : "String",
      "metadata" : {
        "displayName" : "Log Analytics workspace",
        "description" : "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID.",
        "strongType" : "omsWorkspace",
        "assignPermissions" : true
      }
    }
  })

  dynamic "policy_definition_reference" {
    for_each = local.policy_definitions
    content {
      policy_definition_id = policy_definition_reference.value
      parameter_values = jsonencode({
        "logAnalytics" : { "value" : "[parameters('logAnalytics_name')]" }
      })
    }
  }
  dynamic "policy_definition_reference" {
    for_each = local.policy_definitions_without_logAnalytics
    content {
      policy_definition_id = policy_definition_reference.value
    }
  }

}


resource "azurerm_subscription_policy_assignment" "this" {
  count                = length(var.scope)
  name                 = var.assignment_name
  subscription_id      = var.scope[count.index]
  policy_definition_id = var.policy_definition_id
  location             = var.region
  metadata             = var.metadata
  parameters           = var.parameters
  not_scopes           = var.not_scopes
  enforce              = var.enforce

  dynamic "identity" {
    for_each = var.identity != null ? toset([1]) : toset([])
    content {
      type = var.identity
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_message != null ? toset([1]) : toset([])
    content {
      content = var.non_compliance_message
    }
  }
}

resource "azurerm_role_assignment" "this" {
  count                = var.identity == "SystemAssigned" ? 1 : 0
  scope                = var.scope[count.index]
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_subscription_policy_assignment.this[count.index].identity[0].principal_id
}

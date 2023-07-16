variable "policy_definition_display_name" {
  type        = string
  description = "The display name of the Policy Definition or Policy Set Definition. Changing this forces a new resource to be created."
}

variable "policy_definition_id" {
  type        = string
  description = "the id of the policy definition or initiative definition"
}

variable "role_definition_name" {
  type        = string
  description = "the name of the role definiton for the managed identity"
}

variable "assignment_name" {
  type        = string
  description = "The name of the Policy Assignment. Changing this forces a new resource to be created."
}

variable "scope" {
  description = "List of scopes where the policy assignment will be created"
  type        = list(string)
}

variable "identity" {
  type        = string
  description = "The Managed Service Identity Type of this Policy Assignment. Possible values are SystemAssigned or null"
  default     = null
}

variable "region" {
  type        = string
  description = "The Azure location where this policy assignment should exist. This is required when an Identity is assigned. Changing this forces a new resource to be created."
  default     = null
}

variable "metadata" {
  type        = string
  description = "The metadata for the policy assignment. This is a JSON string representing additional metadata that should be stored with the policy assignment."
  default     = null
}

variable "parameters" {
  type        = string
  description = "Parameters for the policy definition. This field is a JSON string that maps to the Parameters field from the Policy Definition. Changing this forces a new resource to be created."
  default     = null
}

variable "not_scopes" {
  type        = list(any)
  description = " A list of the Policy Assignment's excluded scopes. The list must contain Resource IDs (such as Subscriptions e.g. /subscriptions/00000000-0000-0000-000000000000 or Resource Groups e.g./subscriptions/00000000-0000-0000-000000000000/resourceGroups/myResourceGroup)."
  default     = []
}

variable "enforce" {
  type        = bool
  description = "Can be set to 'true' or 'false' to control whether the assignment is enforced (true) or not (false)."
  default     = true
}

variable "policy_type" {
  type        = string
  description = "Define the type of policy for assignment. policy_definition is one policy and a policy_set_definition contains more than one policy"
  default     = "policy_definition"

  validation {
    condition     = contains(["policy_definition", "policy_set_definition"], var.policy_type)
    error_message = "Possible values are policy_definition or policy_set_definition."
  }
}

variable "non_compliance_message" {
  type        = string
  description = "The non-compliance message text to present."
  default     = null
}

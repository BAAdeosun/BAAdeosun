variable "role_based_access_control_enabled" {
  type        = bool
  description = "Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created."
  default     = true
  nullable    = false
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) If `true` local accounts will be disabled. Defaults to `false`. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts)."
  default     = null
}

variable "oidc_issuer_enabled" {
  description = "(Optional) Enable or Disable the OIDC issuer URL. Defaults to false. To enable Azure AD Workload Identity oidc_issuer_enabled must be set to true. More information [can be found in the documentation] (https://learn.microsoft.com/en-gb/azure/aks/use-oidc-issuer)."
  type        = bool
  default     = true
}

variable "client_id" {
  type        = string
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment"
  default     = ""
  nullable    = false
}

variable "client_secret" {
  type        = string
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  default     = ""
  nullable    = false
}

variable "identity_type" {
  type        = string
  description = "(Optional) The type of identity used for the managed cluster. Conflicts with `client_id` and `client_secret`. Possible values are `SystemAssigned` and `UserAssigned`. If `UserAssigned` is set, an `identity_ids` must be set as well."
  validation {
    condition     = var.identity_type == "SystemAssigned" || var.identity_type == "UserAssigned"
    error_message = "`identity_type`'s possible values are `SystemAssigned` and `UserAssigned`"
  }
  default = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
  default     = null
}

variable "rbac_aad" {
  type        = bool
  description = "(Optional) Is Azure Active Directory ingration enabled?"
  default     = true
  nullable    = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  description = "Object ID of groups with admin access."
  default     = null
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = null
}

variable "rbac_aad_client_app_id" {
  type        = string
  description = "The Client ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  default     = true
  nullable    = false
}

variable "rbac_aad_server_app_id" {
  type        = string
  description = "The Server ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_server_app_secret" {
  type        = string
  description = "The Server Secret of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_tenant_id" {
  type        = string
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
  default     = null
}

variable "admin_username" {
  type        = string
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created."
  default     = null
}

variable "public_ssh_key" {
  type        = string
  description = "A custom ssh key to control access to the AKS cluster. Changing this forces a new resource to be created."
  default     = ""
}

# below are specific for this module

variable "sku" {
  description = "The SKU name of the the container KeyVault. Possible values are `standard`, `premium`"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku)
    error_message = "Invalid variable: sku = ${var.sku}. Select valid option from list: ${join(",", ["standard", "premium"])}."
  }
}

variable "tenant_id" {
  description = "Specifies tenant_id."
  type        = string
  default     = null
}

variable "enabled_for_deployment" {
  description = "Specifies enabled_for_deployment."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Specifies enabled_for_disk_encryption. Defaults to true, as recommended by Defender for Cloud."
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Specifies enabled_for_template_deployment."
  type        = bool
  default     = false
}

variable "enabled_rbac_authorization" {
  description = "Specifies enabled_rbac_authorization."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Specifies purge_protection_enabled."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Specifies soft_delete_retention_days."
  type        = number
  default     = 7
}

variable "use_kv_access_policy" {
  description = "Specifies whether to use KeyVault access policy, `true` if yes, `false` to use Azure AD IAM RBAC."
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "List of access policies for the Key Vault."
  type = list(object({
    azure_ad_group_names             = optional(list(string), [])
    object_ids                       = optional(list(string), [])
    azure_ad_user_principal_names    = optional(list(string), [])
    certificate_permissions          = optional(list(string), [])
    key_permissions                  = optional(list(string), [])
    secret_permissions               = optional(list(string), [])
    storage_permissions              = optional(list(string), [])
    azure_ad_service_principal_names = optional(list(string), [])
  }))
  default = []
}
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
  validation {
    condition     = var.stack == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.stack))
    error_message = "Invalid variable: ${var.stack}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "sku" {
  description = "The SKU name of the the container registry. Possible values are `Basic`, `Standard` and `Premium`."
  type        = string
  default     = "Premium"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "Invalid variable: ${var.sku}. SKU used is not valid"
  }
}

variable "georeplication_locations" {
  description = <<DESC
  A list of Azure locations where the container Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  or this can be a list of `string` (each element is a location)
DESC
  type = list(object({
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  }))
  default = null
}

variable "images_retention_enabled" {
  description = "Specifies whether images retention is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "images_retention_days" {
  description = "Specifies the number of images retention days."
  type        = number
  default     = 90
}

variable "azure_services_bypass_allowed" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry."
  type        = bool
  default     = true
}

variable "trust_policy_enabled" {
  description = "Specifies whether the trust policy is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "quarantine_policy_enabled" {
  description = "Boolean value that indicates whether quarantine policy is enabled. Only available with premium SKU"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Boolean value that indicates whether acr zone redundancy is enabled. Only available with premium SKU"
  type        = bool
  default     = false
}

variable "admin_enabled" {
  description = "Boolean value that indicates whether acr has admin user enabled"
  type        = bool
  default     = false
}

variable "anonymous_pull_enabled" {
  description = "Boolean value that indicates whether acr has anonymous pull enabled"
  type        = bool
  default     = false
}

variable "enable_managed_identity_creation" {
  description = "Feature toggle to disable Managed Identity creation."
  type        = bool
  default     = false
}

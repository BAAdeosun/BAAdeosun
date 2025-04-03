
variable "landing_zone_slug" {
  description = "Landing zone acronym, it will beused to generate the resource name"
  type        = string
  validation {
    condition     = var.landing_zone_slug == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.landing_zone_slug))
    error_message = "Invalid variable: ${var.landing_zone_slug}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "custom_name" {
  description = "Custom resource name, it will overide the generate name if set"
  type        = string
  default     = ""
  validation {
    condition     = var.custom_name == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.custom_name))
    error_message = "Invalid variable: ${var.custom_name}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "workload_info" {
  description = "Workload additional info to be used in the resource name"
  type        = string
  default     = ""
  validation {
    condition     = var.workload_info == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.workload_info))
    error_message = "Invalid variable: ${var.workload_info}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "environment" {
  description = "Project environment"
  type        = string
  default     = ""
  validation {
    condition     = var.environment == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.environment))
    error_message = "Invalid variable: ${var.environment}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "stack" {
  description = "Project stack name"
  type        = string
  default     = ""
  validation {
    condition     = var.stack == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.stack))
    error_message = "Invalid variable: ${var.stack}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

variable "waf_enabled" {
  description = "Set to true to enable WAF on Application Gateway."
  type        = bool
  default     = true
}

variable "waf_configuration" {
  description = "Configuration block for WAF."
  type = object({
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = optional(number)
    mode                     = optional(string)
    max_request_body_size_kb = optional(number)
  })
  default = null
}

variable "managed_policies_override" {
  description = "List of managed firewall policies overrides. See https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules"
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = []
}

variable "managed_policies_exclusions" {
  description = "List of managed firewall policies exclusions"
  type = list(object({
    match_variable          = string
    selector_match_operator = string
    selector                = string
  }))
  default = []
}

variable "custom_policies" {
  description = "List of custom firewall policies. See https://docs.microsoft.com/en-us/azure/application-gateway/custom-waf-rules-overview."
  type = list(object({
    name      = string
    rule_type = string
    action    = string
    match_conditions = list(object({
      match_variables = list(object({
        match_variable = string
        selector       = string
      })),
      operator           = string
      negation_condition = bool
      match_values       = list(string)
    }))
  }))
  default = []
}

variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"
  validation {
    condition     = contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode)
    error_message = "Invalid variable: ${var.ddos_protection_mode}. DDoS protectin mode is not valid we only Disabled, Enabled, and VirtualNetworkInherited"
  }
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDOS protection plan only rrequired if DDOS protection mode is Enabled"
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null
}

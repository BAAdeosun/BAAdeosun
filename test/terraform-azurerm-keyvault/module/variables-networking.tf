variable "network_acls" {
  description = "Network rules to apply to key vault."
  type = object({
    bypass         = string
    default_action = string
    # IP address or CIDR
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
}

variable "is_manual_connection" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether the key vault is accessible publicly."
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "Wether the key vault is using a private endpoint."
  type        = bool
  default     = true
}

variable "private_dns_zone_id" {
  description = "Id of the private DNS Zone  to be used by the key vault private endpoint."
  type        = string
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "Id for the subnet used by the key vault private endpoint"
  type        = string
  default     = null
}

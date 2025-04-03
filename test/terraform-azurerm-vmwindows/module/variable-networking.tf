variable "location" {
  description = "Azure location"
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "custom_ipconfig_name" {
  description = "Custom name for the IP config of the NIC. Generated if not set."
  type        = string
  default     = null
}

variable "static_private_ip" {
  description = "Static private IP. Private IP is dynamic if not set."
  type        = string
  default     = null
}

variable "enable_accelerated_networking" {
  description = "Should Accelerated Networking be enabled? Defaults to `false`."
  type        = bool
  default     = false
}

variable "hostname" {
  description = "Custom name for the Virtual Machine Hostname"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet id VM belongs to"
  type        = string
  default     = null
}

variable "network_security_group_id" {
  description = "Network security group id associated with network interface"
  type        = list(string)
  default     = null
}

variable "public_ip_address_id" {
  description = "VM public IP address id"
  type        = list(string)
  default     = null
}

variable "dns_servers" {
  description = "List of dns servers"
  type        = list(string)
  default     = []
}

variable "enable_ip_forwarding" {
  description = "Should IP Forwarding be enabled? Defaults to false"
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network"
  type        = string
  default     = null
}

variable "listener_protocol" {
  description = "Specifies the protocol of listener. Possible values are `Http` or `Https`."
  type        = string
  default     = "Http"
  validation {
    condition     = contains(["Http", "Https"], var.listener_protocol)
    error_message = "Invalid variable: ${var.listener_protocol}. Possible values are `Http` or `Https`."
  }
}

variable "certificate_secret_url" {
  description = "The Secret URL of a Key Vault Certificate, which must be specified when protocol is set to Https."
  type        = string
  default     = null
}

variable "security_rules" {
  type        = any
  description = <<EOT
  "A list of security rules to add to the security group. Each rule should be a map of values to add. See the Readme.md file for further details."
    security_rules = {
      name : "The name of the security rule."
      priority : "Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."
      direction : "A description for this rule. Restricted to 140 characters."
      access : "Specifies whether network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'."
      protocol : "Network protocol this rule applies to. Possible values include 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah' or '*' (which matches all)."
      source_port_range : "Source Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'source_port_ranges' is not specified."
      source_port_ranges : "List of source ports or port ranges. This is required if 'source_port_range' is not specified."
      destination_port_range : "Destination Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'destination_port_ranges' is not specified."
      destination_port_ranges : "List of destination ports or port ranges. This is required if 'destination_port_range' is not specified."
      source_address_prefix : "'CIDR 'or 'source IP range' or '*' to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'source_address_prefixes' is not specified."
      source_address_prefixes : "List of source address prefixes. Tags may not be used. This is required if 'source_address_prefix' is not specified."
      destination_address_prefix : "'CIDR' or 'destination IP range' or '*' to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'destination_address_prefixes' is not specified."
      destination_address_prefixes : "List of destination address prefixes. Tags may not be used. This is required if 'destination_address_prefix' is not specified."
      source_application_security_group_ids : "A List of source Application Security Group IDs."
      destination_application_security_group_ids : "A List of destination Application Security Group IDs."
    }
  EOT
  default     = []
}

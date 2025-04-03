variable "resource_group_name" {
  description = "The name of the resource group where the resources will be deployed"
  type        = string
}

variable "frontend_subnet_id" {
  description = "The ID of the existing frontend subnet"
  type        = string
}

variable "frontend_ip_configuration" {
  description = "Frontend IP configuration"
  type = list(object({
    public_ip_address               = bool
    private_ip_address              = optional(string)
    subnet_id                       = optional(string)
    private_ip_address_allocation   = optional(string)
    private_link_configuration_name = optional(string)
  }))

  validation {
    condition = alltrue([
      for config in var.frontend_ip_configuration : config.private_ip_address_allocation == null || can(contains(["Dynamic", "Static"], config.private_ip_address_allocation))
    ])
    error_message = "The private_ip_address_allocation attribute must be either 'Dynamic' or 'Static' for each object in the list."
  }
}


variable "backend_pools" {
  description = "List of backend pools"
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))

  validation {
    condition = alltrue([
      for pool in var.backend_pools :
      (length(pool.fqdns) > 0 && length(pool.ip_addresses) == 0) ||
      (length(pool.fqdns) == 0 && length(pool.ip_addresses) > 0)
    ])
    error_message = "Each backend pool must have either an fqdn or an ip_address, but not both."
  }
}

variable "backend_http_settings" {
  description = "List of backend HTTP settings"
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    port                                = number
    protocol                            = string
    request_timeout                     = number
    affinity_cookie_name                = optional(string)
    path                                = optional(string)
    probe_name                          = optional(string)
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool)
    authentication_certificate = optional(object({
      name = string
    }))
    trusted_root_certificate_names = optional(string)
    connection_draining = optional(object({
      enabled           = bool
      drain_timeout_sec = number
    }))
  }))
}

variable "http_listeners" {
  description = "List of HTTP listeners"
  type = list(object({
    name                 = string
    frontend_port_name   = string
    protocol             = string
    host_name            = optional(string)
    host_names           = optional(list(string))
    ssl_certificate_name = optional(string)
  }))
}

variable "ssl_certificate" {
  description = "List of SSL Certificates"
  type = list(object({
    name                = optional(string)
    data                = optional(string)
    password            = optional(string)
    key_vault_secret_id = optional(string)
  }))
  default = []
}

variable "routing_rules" {
  description = "List of routing rules"
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    url_path_map_name          = optional(string)
  }))
}

variable "public_ip_allocation" {
  description = "Type of public IP address allocation. Dynamic or Static"
  type        = string
  validation {
    condition     = contains(["Dynamic", "Static"], var.public_ip_allocation)
    error_message = "Invalid variable: ${var.public_ip_allocation}. Public IP address expected values are dynamic or static."
  }
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this Application Gateway service should be located. Changing this forces a new Application Gateway service to be created."
  type        = list(string)
  default     = []
}

variable "rewrite_rule_sets" {
  description = "List of rewrite rules. See https://docs.microsoft.com/en-us/azure/application-gateway/rewrite-http-headers-url"
  type = list(object({
    name = string
    rewrite_rule = list(object({
      rule_name     = string
      rule_sequence = number
      condition = list(object({
        ignore_case = bool
        negate      = bool
        pattern     = string
        variable    = string
      }))
      request_header_configuration = list(object({
        header_name  = string
        header_value = string
      }))
      response_header_configuration = list(object({
        header_name  = string
        header_value = string
      }))
      url = list(object({
        path         = string
        query_string = string
        reroute      = bool
      }))
    }))
  }))
  default = []
}

variable "identity_ids" {
  description = "A list of User Assigned Managed Identity IDs to be assigned to this Application Gateway."
  type        = list(string)
}

variable "autoscale_configuration" {
  description = "Minimum/maximum capacity for autoscaling."
  type = list(object({
    min_capacity = number
    max_capacity = number
  }))

  default = [{
    min_capacity = 1
    max_capacity = 2
  }]
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

variable "probes" {
  description = "List of probes"
  type = list(object({
    name                                      = string
    protocol                                  = string
    host                                      = string
    path                                      = string
    interval                                  = number
    timeout                                   = number
    unhealthy_threshold                       = number
    pick_host_name_from_backend_http_settings = optional(bool)
    minimum_servers                           = optional(number)
    match = object({
      status_code = list(string)
      body        = optional(string)
    })
  }))
  default = []
}

variable "trusted_root_certificates" {
  description = "List of trusted root certificates"
  type = list(object({
    name = string
    data = string
  }))
  default = []
}

variable "authentication_certificates" {
  description = "List of authentication certificates"
  type = list(object({
    name = string
    data = string
  }))
  default = []
}

variable "sku" {
  description = "A list defining the SKU of the Application Gateway being provisioned"
  type = object({
    name     = string
    tier     = string
    capacity = optional(number)
  })
  default = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  validation {
    condition     = contains(["WAF_Medium", "WAF_Large", "WAF_v2"], var.sku.name)
    error_message = "The 'name' field must be one of 'WAF_Medium', 'WAF_Large', or 'WAF_v2'."
  }

  validation {
    condition     = contains(["WAF", "WAF_v2"], var.sku.tier)
    error_message = "The 'tier' field must be either 'WAF' or 'WAF_v2'."
  }
}

variable "enable_http2" {
  description = "A boolean variable that defines if http2 is enabled. Supported values are true or false"
  type        = bool
  default     = true
}

variable "url_path_maps" {
  description = "Map of URL path maps for application gateway."
  type = list(object({
    name                          = string
    default_backend_address_pool  = string
    default_backend_http_settings = string
    path_rules = map(object({
      name                  = string
      backend_address_pool  = string
      backend_http_settings = string
      paths                 = list(string)
    }))
  }))
  default = []
}

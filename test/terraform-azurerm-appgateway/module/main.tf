resource "azurerm_application_gateway" "app_gateway" {
  #checkov:skip=CKV_AZURE_217: "Ensure Azure Application gateways listener that allow connection requests over HTTP"
  #checkov:skip=CKV_AZURE_218: "Ensure Application Gateway defines secure protocols for in transit communication"
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  enable_http2        = var.enable_http2
  firewall_policy_id  = anytrue([for config in var.frontend_ip_configuration : config.public_ip_address]) ? azurerm_web_application_firewall_policy.waf_policy.id : null

  dynamic "identity" {
    for_each = var.sku.tier == "WAF_v2" || var.sku.tier == "Standard_v2" ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = try(var.sku.capacity, null)
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = autoscale_configuration.value.max_capacity
    }
  }

  gateway_ip_configuration {
    name      = "${local.name}-gateway-ip-configuration"
    subnet_id = var.frontend_subnet_id
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                            = "${local.name}-fe-ip-${frontend_ip_configuration.key}"
      public_ip_address_id            = frontend_ip_configuration.value.public_ip_address ? azurerm_public_ip.gateway[0].id : null
      private_ip_address              = try(frontend_ip_configuration.value.private_ip_address, null)
      subnet_id                       = try(frontend_ip_configuration.value.subnet_id, null)
      private_ip_address_allocation   = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
      private_link_configuration_name = try(frontend_ip_configuration.value.private_link_configuration_name, null)
    }
  }


  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_port {
    name = "https-port"
    port = 443
  }

  dynamic "backend_address_pool" {
    for_each = local.backend_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "probe" {
    for_each = local.probes
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      host                                      = probe.value.host
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = try(probe.value.pick_host_name_from_backend_http_settings, null)
      minimum_servers                           = try(probe.value.minimum_servers, null)
      match {
        status_code = probe.value.match.status_code
        body        = try(probe.value.match.body, null)
      }
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      affinity_cookie_name                = try(backend_http_settings.value.affinity_cookie_name, null)
      path                                = try(backend_http_settings.value.path, null)
      probe_name                          = try(backend_http_settings.value.probe_name, null)
      host_name                           = try(backend_http_settings.value.host_name, null)
      pick_host_name_from_backend_address = try(backend_http_settings.value.pick_host_name_from_backend_address, null)

      dynamic "authentication_certificate" {
        for_each = try(backend_http_settings.value.authentication_certificate != null ? [backend_http_settings.value.authentication_certificate] : [], [])
        content {
          name = authentication_certificate.value["name"]
        }
      }

      trusted_root_certificate_names = try(backend_http_settings.value.trusted_root_certificate_names != null ? [backend_http_settings.value.trusted_root_certificate_names] : [], [])

      dynamic "connection_draining" {
        for_each = try(backend_http_settings.value.connection_draining != null ? [backend_http_settings.value.connection_draining] : [], [])
        content {
          enabled           = connection_draining.value["enabled"]
          drain_timeout_sec = connection_draining.value["drain_timeout_sec"]
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = local.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = "${local.name}-fe-ip-0"
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = try(http_listener.value.host_name, null)
      host_names                     = try(http_listener.value.host_names, null)
      ssl_certificate_name           = try(http_listener.value.ssl_certificate_name, null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.routing_rules
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = lookup(request_routing_rule.value, "url_path_map_name", null) != null ? "PathBasedRouting" : "Basic"
      http_listener_name         = request_routing_rule.value.http_listener_name
      url_path_map_name          = lookup(request_routing_rule.value, "url_path_map_name", null)
      backend_address_pool_name  = lookup(request_routing_rule.value, "url_path_map_name", null) == null ? request_routing_rule.value.backend_address_pool_name : null
      backend_http_settings_name = lookup(request_routing_rule.value, "url_path_map_name", null) == null ? request_routing_rule.value.backend_http_settings_name : null
      priority                   = var.sku.tier == "WAF_v2" || var.sku.tier == "Standard_v2" ? (request_routing_rule.key + 1) * 10 : null
    }
  }

  dynamic "url_path_map" {
    for_each = local.url_path_maps
    content {
      name                               = url_path_map.value.name
      default_backend_address_pool_name  = url_path_map.value.default_backend_address_pool
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                       = path_rule.value.name
          backend_address_pool_name  = path_rule.value.backend_address_pool
          backend_http_settings_name = path_rule.value.backend_http_settings
          paths                      = path_rule.value.paths
        }
      }
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = local.trusted_root_certificates != null ? local.trusted_root_certificates : []
    content {
      name = trusted_root_certificate.value.name
      data = trusted_root_certificate.value.data
    }
  }

  dynamic "authentication_certificate" {
    for_each = local.authentication_certificates != null ? local.authentication_certificates : []
    content {
      name = authentication_certificate.value.name
      data = authentication_certificate.value.data
    }
  }

  dynamic "ssl_certificate" {
    for_each = local.ssl_certificate != null ? local.ssl_certificate : []
    content {
      name                = ssl_certificate.value.name
      data                = ssl_certificate.value.data != null ? filebase64(ssl_certificate.value.data) : null
      password            = ssl_certificate.value.password != null ? ssl_certificate.value.password : null
      key_vault_secret_id = ssl_certificate.value.key_vault_secret_id != null ? ssl_certificate.value.key_vault_secret_id : null
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_sets != null ? var.rewrite_rule_sets : []
    iterator = it0
    content {
      name = it0.value.name
      dynamic "rewrite_rule" {
        for_each = it0.value.rewrite_rule
        iterator = it
        content {
          name          = it.value.rule_name
          rule_sequence = it.value.rule_sequence

          dynamic "condition" {
            for_each = it.value.condition
            iterator = it2
            content {
              variable    = it2.value.variable
              pattern     = it2.value.pattern
              ignore_case = it2.value.ignore_case
              negate      = it2.value.negate
            }
          }

          dynamic "request_header_configuration" {
            for_each = it.value.request_header_configuration
            iterator = it3
            content {
              header_name  = it3.value.header_name
              header_value = it3.value.header_value
            }
          }

          dynamic "response_header_configuration" {
            for_each = it.value.response_header_configuration
            iterator = it_response_header_configuration
            content {
              header_name  = it_response_header_configuration.value.header_name
              header_value = it_response_header_configuration.value.header_value
            }
          }


          dynamic "url" {
            for_each = it.value.url
            iterator = it4
            content {
              path         = it4.value.path
              query_string = it4.value.query_string
              reroute      = it4.value.reroute
            }
          }
        }
      }
    }
  }
  tags = merge(var.default_tags, var.extra_tags)
}

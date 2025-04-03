resource "azurerm_web_application_firewall_policy" "waf_policy" {
  # This is done by setting OWASP 3.1 to be default rule if no overrides are provided via variables.
  #checkov:skip=CKV_AZURE_135: "Ensure Application Gateway WAF prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell"
  name                = format("%swafpolicy", lower(replace(local.name, "/[[:^alnum:]]/", "")))
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(var.default_tags, var.extra_tags)

  policy_settings {
    enabled                     = var.waf_enabled
    file_upload_limit_in_mb     = try(coalesce(var.waf_configuration.file_upload_limit_mb != null ? var.waf_configuration.file_upload_limit_mb : null, 100), 100)
    max_request_body_size_in_kb = try(coalesce(var.waf_configuration.max_request_body_size_in_kb != null ? var.waf_configuration.max_request_body_size_kb : null, 128), 128)
    mode                        = try(coalesce(var.waf_configuration.mode != null ? var.waf_configuration.firewall_mode : null, "Detection"), "Detection")
    request_body_check          = true
  }

  dynamic "custom_rules" {
    for_each = var.custom_policies != null ? var.custom_policies : []
    iterator = cp
    content {
      name      = cp.value.name
      priority  = (cp.key + 1) * 10
      rule_type = cp.value.rule_type
      action    = cp.value.action

      dynamic "match_conditions" {
        for_each = cp.value.match_conditions != null ? cp.value.match_conditions : []
        iterator = mc
        content {
          dynamic "match_variables" {
            for_each = mc.value.match_variables
            iterator = mv
            content {
              variable_name = mv.value.match_variable
              selector      = mv.value.selector
            }
          }

          operator           = mc.value.operator
          negation_condition = mc.value.negation_condition
          match_values       = mc.value.match_values
        }
      }
    }
  }

  managed_rules {
    managed_rule_set {
      type    = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_type : null, "OWASP")
      version = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_version : null, "3.0")

      dynamic "rule_group_override" {
        for_each = var.managed_policies_override != null ? var.managed_policies_override : []
        iterator = rg
        content {
          rule_group_name = rg.value.rule_group_name

          dynamic "rule" {
            for_each = [for rule_id in rg.value.disabled_rules : {
              id      = rule_id
              enabled = false
              action  = "Block"
            }]
            iterator = r
            content {
              id      = r.value.id
              enabled = r.value.enabled
              action  = r.value.action
            }
          }
        }
      }
    }

    dynamic "exclusion" {
      for_each = var.managed_policies_exclusions != null ? var.managed_policies_exclusions : []
      iterator = ex
      content {
        match_variable          = ex.value.match_variable
        selector                = ex.value.selector
        selector_match_operator = ex.value.selector_match_operator
      }
    }
  }

}

resource "azurerm_public_ip" "gateway" {
  count                   = length([for config in var.frontend_ip_configuration : config if config.public_ip_address])
  name                    = format("pip-%s-%d", local.name, count.index)
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  domain_name_label       = format("pip-%s-%d", local.name, count.index)
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = merge(var.default_tags, var.extra_tags)
}

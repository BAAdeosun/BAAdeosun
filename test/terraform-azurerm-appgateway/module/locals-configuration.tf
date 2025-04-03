locals {
  backend_pools               = fileexists("../${path.module}/backend_address_pool.json") ? jsondecode(file("${path.module}/backend_address_pool.json")) : var.backend_pools
  backend_http_settings       = fileexists("../${path.module}/backend_http_settings.json") ? jsondecode(file("${path.module}/backend_http_settings.json")) : var.backend_http_settings
  http_listeners              = fileexists("../${path.module}/http_listener.json") ? jsondecode(file("${path.module}/http_listener.json")) : var.http_listeners
  routing_rules               = fileexists("../${path.module}/request_routing_rule.json") ? jsondecode(file("${path.module}/request_routing_rule.json")) : var.routing_rules
  probes                      = fileexists("../${path.module}/probes.json") ? jsondecode(file("${path.module}/probes.json")) : var.probes
  trusted_root_certificates   = fileexists("../${path.module}/trusted_root_certificates.json") ? jsondecode(file("${path.module}/trusted_root_certificates.json")) : var.trusted_root_certificates
  authentication_certificates = fileexists("../${path.module}/authentication_certificates.json") ? jsondecode(file("${path.module}/authentication_certificates.json")) : var.authentication_certificates
  ssl_certificate             = fileexists("../${path.module}/ssl_certificate.json") ? jsondecode(file("${path.module}/ssl_certificate.json")) : var.ssl_certificate
  url_path_maps               = fileexists("../${path.module}/url_path_maps.json") ? jsondecode(file("${path.module}/url_path_maps.json")) : var.url_path_maps
}

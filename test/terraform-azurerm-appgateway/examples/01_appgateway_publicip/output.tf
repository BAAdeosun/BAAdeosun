output "id" {
  description = "Id of the application gateway."
  value       = module.appgw.id
}

output "name" {
  description = "Name of the application gateway."
  value       = module.appgw.name
}

output "public_ip_id" {
  description = "The ID of appgw Public IP."
  value       = length(module.appgw.public_ip_id) > 0 ? module.appgw.public_ip_id : null
}

output "public_ip_address" {
  description = "The IP address value that was allocated."
  value       = length(module.appgw.public_ip_address) > 0 ? module.appgw.public_ip_address : null
}

output "public_ip_fqdn" {
  description = "The Public IP FQDN"
  value       = length(module.appgw.public_ip_fqdn) > 0 ? module.appgw.public_ip_fqdn : null
}

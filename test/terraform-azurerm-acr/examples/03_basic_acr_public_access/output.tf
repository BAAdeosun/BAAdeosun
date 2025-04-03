output "acr_id" {
  description = "The Container Registry ID."
  value       = module.acr.acr_id
}

output "acr_name" {
  description = "The Container Registry name."
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = module.acr.acr_login_server
}

output "id_acr_pull" {
  description = "Id to the user-managed identity with ACrPull Role"
  value       = module.acr.id_acr_pull
}

output "id_acr_push" {
  description = "Id to the user-managed identity with ACrPush Role"
  value       = module.acr.id_acr_push
}
output "acr_data" {
  value     = module.acr.acr_data
  sensitive = true
}

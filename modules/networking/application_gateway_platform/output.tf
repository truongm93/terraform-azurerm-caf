output "id" {
  value = azurerm_application_gateway.agw.id
}

output "name" {
  value = azurecaf_name.agw.result
}

output "frontend_ip_configurations" {
  value = var.settings.front_end_ip_configurations
}

output "frontend_ports" {
  value = var.settings.front_end_ports
}

output "ssl_certificates" {
  value = try(var.settings.ssl_certs, null)
}

output "private_ip_address" {
  value = local.private_ip_address
}

output "resource_group_name" {
  value = local.resource_group_name
}

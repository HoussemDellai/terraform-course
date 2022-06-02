output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname 
}

output "webapp_ips" {
  value = azurerm_linux_web_app.app.outbound_ip_addresses
}
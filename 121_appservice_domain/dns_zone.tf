# DNS Zone to configure the domain name
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.domain_name
  resource_group_name = azurerm_resource_group.rg.name
}

# DNS Zone A record
resource "azurerm_dns_a_record" "dns_a_record" {
  name                = "test"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = ["1.2.3.4"] # just example IP address
}

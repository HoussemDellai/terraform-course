# App Service Domain
# REST API reference: https://docs.microsoft.com/en-us/rest/api/appservice/domains/createorupdate
resource "azapi_resource" "appservice_domain" {
  type                      = "Microsoft.DomainRegistration/domains@2022-09-01"
  name                      = var.domain_name
  parent_id                 = azurerm_resource_group.rg.id
  location                  = "global"
  schema_validation_enabled = true

  body = jsonencode({

    properties = {
      autoRenew = false
      dnsType   = "AzureDns"
      dnsZoneId = azurerm_dns_zone.dns_zone.id
      privacy   = false

      consent = {
        agreementKeys = ["DNRA"]
        agreedBy      = var.AgreedBy_IP_v6 # "2a04:cec0:11d9:24c8:8898:3820:8631:d83"
        agreedAt      = var.AgreedAt_DateTime # "2023-08-10T11:50:59.264Z"
      }

      contactAdmin = {
        nameFirst = var.contact.nameFirst
        nameLast  = var.contact.nameLast
        email     = var.contact.email
        phone     = var.contact.phone

        addressMailing = {
          address1   = var.contact.addressMailing.address1
          city       = var.contact.addressMailing.city
          state      = var.contact.addressMailing.state
          country    = var.contact.addressMailing.country
          postalCode = var.contact.addressMailing.postalCode
        }
      }

      contactRegistrant = {
        nameFirst = var.contact.nameFirst
        nameLast  = var.contact.nameLast
        email     = var.contact.email
        phone     = var.contact.phone

        addressMailing = {
          address1   = var.contact.addressMailing.address1
          city       = var.contact.addressMailing.city
          state      = var.contact.addressMailing.state
          country    = var.contact.addressMailing.country
          postalCode = var.contact.addressMailing.postalCode
        }
      }

      contactBilling = {
        nameFirst = var.contact.nameFirst
        nameLast  = var.contact.nameLast
        email     = var.contact.email
        phone     = var.contact.phone

        addressMailing = {
          address1   = var.contact.addressMailing.address1
          city       = var.contact.addressMailing.city
          state      = var.contact.addressMailing.state
          country    = var.contact.addressMailing.country
          postalCode = var.contact.addressMailing.postalCode
        }
      }

      contactTech = {
        nameFirst = var.contact.nameFirst
        nameLast  = var.contact.nameLast
        email     = var.contact.email
        phone     = var.contact.phone

        addressMailing = {
          address1   = var.contact.addressMailing.address1
          city       = var.contact.addressMailing.city
          state      = var.contact.addressMailing.state
          country    = var.contact.addressMailing.country
          postalCode = var.contact.addressMailing.postalCode
        }
      }
    }
  })
}

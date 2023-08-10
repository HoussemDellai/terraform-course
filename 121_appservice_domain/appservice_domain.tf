# resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-dns-demo12"
  location = "westeurope"
}

# {
#     "id": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-dns/providers/Microsoft.DomainRegistration/domains/houssemd.com",
#     "name": "houssemd.com",
#     "type": "Microsoft.DomainRegistration/domains",
#     "location": "global",
#     "tags": {},
#     "properties": {
#         "registrationStatus": "Active",
#         "provisioningState": "Succeeded",
#         "nameServers": [
#             "ns1-37.azure-dns.com",
#             "ns2-37.azure-dns.net",
#             "ns3-37.azure-dns.org",
#             "ns4-37.azure-dns.info"
#         ],
#         "privacy": true,
#         "createdTime": "2023-03-10T14:18:13",
#         "expirationTime": "2024-03-10T14:18:13",
#         "autoRenew": true,
#         "readyForDnsRecordManagement": true,
#         "managedHostNames": [],
#         "domainNotRenewableReasons": [
#             "ExpirationNotInRenewalTimeRange"
#         ],
#         "dnsType": "AzureDns",
#         "dnsZoneId": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourcegroups/rg-dns/providers/Microsoft.Network/dnszones/houssemd.com"
#     }
# }

resource "azapi_resource" "appservice_domain" {
  type                      = "Microsoft.DomainRegistration/domains@2022-03-01"
  # type                      = "Microsoft.DomainRegistration/domains@2022-09-01"
  name                      = "houssem12.com"
  parent_id                 = azurerm_resource_group.rg.id
  location                  = "global" # azurerm_resource_group.rg.location # global
  schema_validation_enabled = false

  body = jsonencode({

    properties = {
      autoRenew = false
      dnsType   = "AzureDns"
      dnsZoneId = azurerm_dns_zone.dns_zone.id
      privacy   = false

      consent = {
        agreementKeys = ["DNRA"]
        agreedBy = "2a04:cec0:11d9:24c8:8898:3820:8631:d83" # IPv6
        agreedAt = "2023-08-10T11:50:59.264Z"
      }
      contactAdmin = {
        nameFirst = "Houssem"
        nameLast  = "Dellai"
        email     = "houssem@dell.ai"
        phone     = "+33.762954328"
        addressMailing = {
          address1   = "1 Microsoft Way"
          city       = "Redmond"
          state      = "WA"
          country    = "US"
          postalCode = "98052"
        }
      }
      contactRegistrant = {
        nameFirst = "Houssem"
        nameLast  = "Dellai"
        email     = "houssem@dell.ai"
        phone     = "+33.762954328"
        addressMailing = {
          address1   = "1 Microsoft Way"
          city       = "Redmond"
          state      = "WA"
          country    = "US"
          postalCode = "98052"
        }
      }
      contactBilling = {
        nameFirst = "Houssem"
        nameLast  = "Dellai"
        email     = "houssem@dell.ai"
        phone     = "+33.762954328"
        addressMailing = {
          address1   = "1 Microsoft Way"
          city       = "Redmond"
          state      = "WA"
          country    = "US"
          postalCode = "98052"
        }
      }
      contactRegistrant = {
        nameFirst = "Houssem"
        nameLast  = "Dellai"
        email     = "houssem@dell.ai"
        phone     = "+33.762954328"
        addressMailing = {
          address1   = "1 Microsoft Way"
          city       = "Redmond"
          state      = "WA"
          country    = "US"
          postalCode = "98052"
        }
      }
      contactTech = {
        nameFirst = "Houssem"
        nameLast  = "Dellai"
        email     = "houssem@dell.ai"
        phone     = "+33.762954328"
        addressMailing = {
          address1   = "1 Microsoft Way"
          city       = "Redmond"
          state      = "WA"
          country    = "US"
          postalCode = "98052"
        }
      }
    }
  })
}

# create DNS Zone using azurerm
resource "azurerm_dns_zone" "dns_zone" {
  name                = "houssem12.com"
  resource_group_name = azurerm_resource_group.rg.name
}

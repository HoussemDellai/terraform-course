variable "domain_name" {
  type = string
  validation {
    condition     = length(var.domain_name) > 0 && (endswith(var.domain_name, ".com") || endswith(var.domain_name, ".net") || endswith(var.domain_name, ".co.uk") || endswith(var.domain_name, ".org") || endswith(var.domain_name, ".nl") || endswith(var.domain_name, ".in") || endswith(var.domain_name, ".biz") || endswith(var.domain_name, ".org.uk") || endswith(var.domain_name, ".co.in"))
    error_message = "Available top level domains are: com, net, co.uk, org, nl, in, biz, org.uk, and co.in"
  }
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "AgreedBy_IP_v6" { # "2a04:cec0:11d9:24c8:8898:3820:8631:d83"
  type = string
}

variable "AgreedAt_DateTime" {  # "2023-08-10T11:50:59.264Z"
  type = string
}

variable "contact" {
  type = object({
    nameFirst = string
    nameLast  = string
    email     = string
    phone     = string
    addressMailing = object({
      address1   = string
      city       = string
      state      = string
      country    = string
      postalCode = string
    })
  })
}

#------------------------------------------------------
# string, number, list, map
#------------------------------------------------------

variable "cost_center_id" {
  type    = number
  default = 3
}

variable "is_production" {
  type    = bool
  default = true
}

variable "allowed_locations" {
  type    = list(string)
  default = ["westeurope", "eastus", "westus"]
}

variable "custom_tags" {
  type = map(string)
  default = {
    "project"     = "frontend-application"
    "owner"       = "team-one"
    "environment" = "UAT"
  }
}

#------------------------------------------------------
# sensitive, validation, length, substr
#------------------------------------------------------

variable "rg_name" {
  type        = string
  description = "The name of the Azure Resource Group."
  default     = "rg-frontend_app"
  sensitive   = true

  validation {
    condition = length(var.rg_name) > 3 && substr(var.rg_name, 0, 3) == "rg-"
    # condition     = can(regex("^rg-", var.rg_name))
    error_message = "The rg_name value must be valid, starting with \"rg-\"."
  }
}

#------------------------------------------------------
# anytrue, for, contains
#------------------------------------------------------

variable "location" {
  type        = string
  description = "Location of resources"
  default     = "westeurope"

  validation {
    condition = (anytrue([for l in ["eastus", "westeurope"] : l == var.location]))
    # condition   = contains(["eastus", "westeurope"], lower(var.location))
    error_message = "The region should be eastus or westeurope."
  }
}
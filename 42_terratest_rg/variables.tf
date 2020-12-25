variable "location" {
  description = "The location to set for the resource group."
  type        = string
  default     = "East US"
}

variable "postfix" {
  description = "A postfix string to centrally mitigate resource name collisions."
  type        = string
  default     = "resource"
}
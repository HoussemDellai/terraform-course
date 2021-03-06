# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/advisor_recommendations

data "azurerm_advisor_recommendations" "advisor" {
  filter_by_category = ["security",
                        "cost",
                        "HighAvailability",
                        "Performance",
                        "OperationalExcellence"]
  # filter_by_resource_groups = ["example-resgroups"]
}

output "recommendations" {
  value = data.azurerm_advisor_recommendations.advisor.recommendations
}
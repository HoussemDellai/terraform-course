resource "azurerm_app_service_plan" "res-2" {
  kind                = "linux"
  location            = "westeurope"
  name                = "appserviceplan-web-21"
  reserved            = true
  resource_group_name = "rg-terraform-web-sql-db"
  sku {
    size = "B1"
    tier = "Basic"
  }
  depends_on = [
    azurerm_resource_group.res-54,
  ]
}
resource "azurerm_sql_database" "res-12" {
  location            = "westeurope"
  name                = "ProductsDB"
  resource_group_name = "rg-terraform-web-sql-db"
  server_name         = "terraform-sqlserver-021"
  depends_on = [
    # Depending on "/subscriptions/4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3/resourceGroups/rg-terraform-web-sql-db/providers/Microsoft.Sql/servers/terraform-sqlserver-021", which is not imported by Terraform.
  ]
}
resource "azurerm_mssql_server_vulnerability_assessment" "res-27" {
  server_security_alert_policy_id = "/subscriptions/4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3/resourceGroups/rg-terraform-web-sql-db/providers/Microsoft.Sql/servers/terraform-sqlserver-021/securityAlertPolicies/Default"
  storage_container_path          = ""
  depends_on = [
    # Depending on "/subscriptions/4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3/resourceGroups/rg-terraform-web-sql-db/providers/Microsoft.Sql/servers/terraform-sqlserver-021", which is not imported by Terraform.
  ]
}
resource "azurerm_app_service_custom_hostname_binding" "res-36" {
  app_service_name    = "mywebapp-01357"
  hostname            = "mywebapp-01357.azurewebsites.net"
  resource_group_name = "rg-terraform-web-sql-db"
  depends_on = [
    # Depending on "/subscriptions/4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3/resourceGroups/rg-terraform-web-sql-db/providers/Microsoft.Web/sites/mywebapp-01357", which is not imported by Terraform.
  ]
}
resource "azurerm_resource_group" "res-54" {
  location = "westeurope"
  name     = "rg-terraform-web-sql-db"
  tags = {
    environment = "preproduction"
  }
}
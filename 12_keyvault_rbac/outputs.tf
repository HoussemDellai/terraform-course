output "kv_id" {
  value = azurerm_key_vault.keyvault.id
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}

output "secret_id" {
  value = azurerm_key_vault_secret.database-password.id
}


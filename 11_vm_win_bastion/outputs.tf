output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm_ip" {
  value = azurerm_windows_virtual_machine.vm.public_ip_address
}


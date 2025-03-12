output "az_rg_name" {
  value     = azurerm_resource_group.az_rg.name
  sensitive = false
}

output "win_public_ip" {
  value     = azurerm_public_ip.win_public_ip.ip_address
  sensitive = false
}

output "ubuntu_public_ip" {
  value     = azurerm_public_ip.ubuntu_public_ip.ip_address
  sensitive = false
}

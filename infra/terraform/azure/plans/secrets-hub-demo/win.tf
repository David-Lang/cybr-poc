resource "azurerm_network_interface" "windows_nic" {
  name                = "${local.compute_name_win}-nic"
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_public_ip.id
  }
}

resource "azurerm_public_ip" "win_public_ip" {
  name                = "${local.compute_name_win}-public-ip"
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  allocation_method   = "Dynamic" # Can also be "Static"
  sku                 = "Basic"   # Can also be "Standard" depending on requirements
}

resource "azurerm_virtual_machine" "windows_vm" {
  name                          = local.compute_name_win
  location                      = azurerm_resource_group.az_rg.location
  resource_group_name           = azurerm_resource_group.az_rg.name
  network_interface_ids         = [azurerm_network_interface.windows_nic.id]
  vm_size                       = "Standard_DS3_v2"
  delete_os_disk_on_termination = "true"

  storage_os_disk {
    name              = "${local.compute_name_win}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = local.compute_name_win
    admin_username = var.compute_user
    admin_password = var.compute_pwd
    custom_data    = filebase64("${path.module}/init_script_win.ps1")
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.az_compute-identity1.id]
  }
}

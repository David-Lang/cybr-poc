resource "azurerm_public_ip" "ubuntu_public_ip" {
  name                = "${local.compute_name_ubuntu}-public-ip"
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  allocation_method   = "Static" # Can also be "Static" OR "Dynamic"
  sku                 = "Basic"   # Can also be "Standard" depending on requirements
}

resource "azurerm_network_interface" "ubuntu_nic" {
  name                = "${local.compute_name_ubuntu}-nic"
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name

  ip_configuration {
    name                          = "${local.compute_name_ubuntu}-ipconfig1"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu_public_ip.id
  }
}

resource "azurerm_virtual_machine" "ubuntu_vm" {
  name                          = local.compute_name_ubuntu
  location                      = azurerm_resource_group.az_rg.location
  resource_group_name           = azurerm_resource_group.az_rg.name
  network_interface_ids         = [azurerm_network_interface.ubuntu_nic.id]
  vm_size                       = "Standard_B1s"
  delete_os_disk_on_termination = "true"

  storage_os_disk {
    name              = "${local.compute_name_ubuntu}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "ubuntu1" #local.compute_name_ubuntu
    admin_username = "adminuser"
    admin_password = var.compute_pwd
    #custom_data    = filebase64("${path.module}/init_script_ubuntu.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

#  identity {
#    type         = "UserAssigned"
#    identity_ids = [azurerm_user_assigned_identity.az_compute-identity1.id]
#  }
}


resource "azurerm_key_vault" "akv1" {
  name                       = "${local.name_prefix}-akv1"
  location                   = azurerm_resource_group.az_rg.location
  resource_group_name        = azurerm_resource_group.az_rg.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List",
      "Purge",
    ]

    certificate_permissions = [
      "Get",
      "List",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}


resource "azurerm_key_vault" "akv2" {
  name                       = "${local.name_prefix}-akv2"
  location                   = azurerm_resource_group.az_rg.location
  resource_group_name        = azurerm_resource_group.az_rg.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List",
      "Purge",
    ]

    certificate_permissions = [
      "Get",
      "List",
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_secret" "secret2a" {
  name         = "secret2a"
  value        = "secret2a-s3cureP@ssw0rd!"
  key_vault_id = azurerm_key_vault.akv2.id
}

resource "azurerm_key_vault_secret" "secret2b" {
  name         = "secret2b"
  value        = "secret2b-s3cureP@ssw0rd!"
  key_vault_id = azurerm_key_vault.akv2.id
}

resource "azurerm_key_vault" "akv3" {
  name                       = "${local.name_prefix}-akv3"
  location                   = azurerm_resource_group.az_rg.location
  resource_group_name        = azurerm_resource_group.az_rg.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  properties {
    enable_rbac_authorization  = true
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = [
      azurerm_public_ip.win_public_ip.ip_address,
      azurerm_public_ip.ubuntu_public_ip.ip_address
    ]
  }

}

## Role assignment (example: Key Vault Secrets Officer)
#resource "azurerm_role_assignment" "example" {
#  scope                = azurerm_key_vault.akv3.id
#  role_definition_name = "Key Vault Secrets Officer"
#  principal_id         = var.principal_id
#}
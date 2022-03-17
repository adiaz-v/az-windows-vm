provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = "1012c700-e42c-4aa6-9f4d-3dac6033b0f4"
  client_id = var.appId
  client_certificate_path = var.client_certificate_path
  client_certificate_password = var.client_certificate_password
 }



 data "azurerm_key_vault_secret" "vmAdminPassword" {
    key_vault_id = "/subscriptions/add34113-28e5-49c6-985b-0b8429019192/resourceGroups/rg-kv-eastus-prod/providers/Microsoft.KeyVault/vaults/kv-cloudops-eastus"
    name = "tnlocaladmin"

}

data "azurerm_key_vault_certificate" "spCert" {
    key_vault_id = "/subscriptions/add34113-28e5-49c6-985b-0b8429019192/resourceGroups/rg-kv-eastus-prod/providers/Microsoft.KeyVault/vaults/kv-cloudops-eastus"
    name = "InfraDeployer"
}




resource "azurerm_resource_group" "main" {
  name     = var.rgName
  location = var.location
}


resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfiguration1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address = var.private_ip_address
  }
  depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_availability_set" "aset-dns" {
    name = "aset-dnsfwrd-eastus"
    resource_group_name = azurerm_resource_group.main.name
    location = var.location
    depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.prefix
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  depends_on = [
    azurerm_resource_group.main
  ]
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B2ms"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-AZTNVM09"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.prefix
    admin_username = var.admin_username
    admin_password = data.azurerm_key_vault_secret.vmAdminPassword.value
  }
  os_profile_windows_config {
      enable_automatic_upgrades = true
  }
  availability_set_id = azurerm_availability_set.aset-dns.id
  tags = var.tags
}
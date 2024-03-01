resource "random_password" "virtual_machine_password" {
  length           = 16
  special          = false
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "_%@"
}

resource "azurerm_linux_virtual_machine_scale_set" "linux_marketplace_vmss" {
  count                  = var.os_type == "linux" && var.vmss_mode == "uniform" && var.custom_image_name == "" || var.custom_image_gallery_name == "" ? 1 : 0
  name                   = var.vmss_name
  location               = var.location
  resource_group_name    = var.resourcegroup_name
  admin_username         = "DevoAdmin"
  admin_password         = var.virtual_machine_password == "" ? resource.random_password.virtual_machine_password.result : var.virtual_machine_password
  instances              = var.nb_instances
  sku                    = var.vm_size
  zones                  = var.zones
  zone_balance           = var.zone_balance
  single_placement_group = var.single_placement_group

  scale_in {
    rule                   = var.rule
    force_deletion_enabled = var.force_deletion_enabled
  }
  os_disk {
    caching              = var.os_disk_caching #"ReadWrite"
    storage_account_type = var.os_disk_type    #"Standard_LRS"
  }


  network_interface {
    name    = lower("nic1-${var.vmss_name}")
    primary = true

    ip_configuration {
      name      = "ipconfig1"
      primary   = true
      subnet_id = data.azurerm_subnet.vmss_subnet.id
    }
  }

  source_image_reference {
    publisher = var.vm_image["publisher"]
    offer     = var.vm_image["offer"]
    sku       = var.vm_image["sku"]
    version   = var.vm_image["version"]
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}


resource "azurerm_windows_virtual_machine_scale_set" "windows_marketplace_vmss" {
  count                  = var.os_type == "windows" && var.vmss_mode == "uniform" && var.custom_image_name == "" || var.custom_image_gallery_name == "" ? 1 : 0
  name                   = var.vmss_name
  location               = var.location
  resource_group_name    = var.resourcegroup_name
  admin_username         = "DevoAdmin"
  admin_password         = var.virtual_machine_password == "" ? resource.random_password.virtual_machine_password.result : var.virtual_machine_password
  instances              = var.nb_instances
  sku                    = var.vm_size
  zones                  = var.zones
  zone_balance           = var.zone_balance
  single_placement_group = var.single_placement_group

  scale_in {
    rule                   = var.rule
    force_deletion_enabled = var.force_deletion_enabled
  }

  os_disk {
    caching              = var.os_disk_caching #"ReadWrite"
    storage_account_type = var.os_disk_type    #"Standard_LRS"
  }


  network_interface {
    name    = lower("nic1-${var.vmss_name}")
    primary = true

    ip_configuration {
      name      = "ipconfig1"
      primary   = true
      subnet_id = data.azurerm_subnet.vmss_subnet.id
    }
  }

  source_image_reference {
    publisher = var.vm_image["publisher"]
    offer     = var.vm_image["offer"]
    sku       = var.vm_image["sku"]
    version   = var.vm_image["version"]
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}

resource "azurerm_orchestrated_virtual_machine_scale_set" "flexible_marketplace_vmss" {
  count                       = var.vmss_mode == "flexible" && var.custom_image_name == "" || var.custom_image_gallery_name == "" ? 1 : 0
  name                        = var.vmss_name
  resource_group_name         = var.resourcegroup_name
  location                    = var.location
  instances                   = var.nb_instances
  zones                       = var.zones
  zone_balance                = var.zone_balance
  platform_fault_domain_count = 1 #Max Spreading https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones#availability-considerations
  single_placement_group      = var.single_placement_group
  tags                        = var.tags

  source_image_reference {
    publisher = var.vm_image["publisher"]
    offer     = var.vm_image["offer"]
    sku       = var.vm_image["sku"]
    version   = var.vm_image["version"]
  }
}




resource "azurerm_windows_virtual_machine_scale_set" "windows_custom_vmss" {
  count                  = var.os_type == "windows" && var.vmss_mode == "uniform" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? 1 : 0
  name                   = var.vmss_name
  location               = var.location
  resource_group_name    = var.resourcegroup_name
  admin_username         = "DevoAdmin"
  admin_password         = var.virtual_machine_password == "" ? resource.random_password.virtual_machine_password.result : var.virtual_machine_password
  instances              = var.nb_instances
  sku                    = var.vm_size
  zones                  = var.zones
  zone_balance           = var.zone_balance
  single_placement_group = var.single_placement_group

  scale_in {
    rule                   = var.rule
    force_deletion_enabled = var.force_deletion_enabled
  }

  os_disk {
    caching              = var.os_disk_caching #"ReadWrite"
    storage_account_type = var.os_disk_type    #"Standard_LRS"
  }


  network_interface {
    name    = lower("nic1-${var.vmss_name}")
    primary = true

    ip_configuration {
      name      = "ipconfig1"
      primary   = true
      subnet_id = data.azurerm_subnet.vmss_subnet.id
    }
  }

  source_image_id = data.azurerm_shared_image.custom_image[0].id

  identity {
    type = var.identity_type
  }

  tags = var.tags
}


resource "azurerm_linux_virtual_machine_scale_set" "linux_custom_vmss" {
  count                  = var.os_type == "linux" && var.vmss_mode == "uniform" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? 1 : 0
  name                   = var.vmss_name
  location               = var.location
  resource_group_name    = var.resourcegroup_name
  admin_username         = "DevoAdmin"
  admin_password         = var.virtual_machine_password == "" ? resource.random_password.virtual_machine_password.result : var.virtual_machine_password
  instances              = var.nb_instances
  sku                    = var.vm_size
  zones                  = var.zones
  zone_balance           = var.zone_balance
  single_placement_group = var.single_placement_group

  scale_in {
    rule                   = var.rule
    force_deletion_enabled = var.force_deletion_enabled
  }
  os_disk {
    caching              = var.os_disk_caching #"ReadWrite"
    storage_account_type = var.os_disk_type    #"Standard_LRS"
  }


  network_interface {
    name    = lower("nic1-${var.vmss_name}")
    primary = true

    ip_configuration {
      name      = "ipconfig1"
      primary   = true
      subnet_id = data.azurerm_subnet.vmss_subnet.id
    }
  }

  source_image_id = data.azurerm_shared_image.custom_image[0].id

  identity {
    type = var.identity_type
  }

  tags = var.tags
}


resource "azurerm_orchestrated_virtual_machine_scale_set" "flexible_custom_vmss" {
  count                       = var.vmss_mode == "flexible" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? 1 : 0
  name                        = var.vmss_name
  resource_group_name         = var.resourcegroup_name
  location                    = var.location
  instances                   = var.nb_instances
  zones                       = var.zones
  zone_balance                = var.zone_balance
  platform_fault_domain_count = 1 #Max Spreading https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones#availability-considerations
  single_placement_group      = var.single_placement_group
  tags                        = var.tags

  source_image_id = data.azurerm_shared_image.custom_image[0].id
}
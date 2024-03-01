data "azurerm_subnet" "vmss_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resourcegroup_name
}


data "azurerm_shared_image" "custom_image" {
  count               = var.custom_image_name != "" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? 1 : 0
  gallery_name        = var.custom_image_gallery_name
  name                = var.custom_image_name
  resource_group_name = var.custom_image_name_resource_group
}
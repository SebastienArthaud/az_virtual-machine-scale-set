module "az_windows_virtual_machine_scale_set" {
  source                           = "../../az_virtual-machine-scale-set"
  vmss_name                        = var.name
  resourcegroup_name               = var.vm_resourcegroup_name
  location                         = var.location
  vnet_name                        = var.vnet_name
  subnet_name                      = var.subnet_name
  nb_instances                     = var.nb_instances
  custom_image_name                = var.custom_image_name
  custom_image_gallery_name        = var.custom_image_gallery_name
  custom_image_name_resource_group = var.vm_resourcegroup_name
}
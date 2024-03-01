output "flexible_scale_set_id" {
  description = "Id du scale set flexible créé"
  value       = var.vmss_mode == "flexible" ? resource.azurerm_orchestrated_virtual_machine_scale_set.flexible_marketplace_vmss[0].id : "No VMSS created because a specialized custom image has been given in the inputs"
}

output "uniform_windows_scale_set_id" {
  description = "Id du scale set uniforme windows créé"
  value       = var.vmss_mode == "uniform" && var.os_type == "windows" && var.custom_image_name == "" || var.custom_image_gallery_name == "" ? resource.azurerm_windows_virtual_machine_scale_set.windows_marketplace_vmss[0].id : null
}

output "uniform_linux_scale_set_id" {
  description = "Id du scale set uniforme linux créé"
  value       = var.vmss_mode == "uniform" && var.os_type == "linux" && var.custom_image_name == "" || var.custom_image_gallery_name == "" ? resource.azurerm_linux_virtual_machine_scale_set.linux_marketplace_vmss[0].id : null
}




output "custom_uniform_linux_vmss_id" {
  description = "Id du scale set uniform linux créé"
  value       = var.vmss_mode == "uniform" && var.os_type == "linux" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? resource.azurerm_linux_virtual_machine_scale_set.linux_custom_vmss[0].id : null
}


output "custom_uniform_windows_vmss_id" {
  description = "Id du scale set uniforme windows créé"
  value       = var.vmss_mode == "uniform" && var.os_type == "windows" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? resource.azurerm_windows_virtual_machine_scale_set.windows_custom_vmss[0].id : null
}


output "custom_flexible_vmss_id" {
  description = "Id du scale set flexible créé"
  value       = var.vmss_mode == "flexible" && var.custom_image_name != "" && var.custom_image_gallery_name != "" ? resource.azurerm_orchestrated_virtual_machine_scale_set.flexible_custom_vmss[0].id : null
}
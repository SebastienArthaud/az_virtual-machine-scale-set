# az_virtual-machine-scale-set

## Example usage 

Pour voir un exemple d'utilisation de ce module ce réferer au dossier "example".
Cloner le repot et effectuer un terraform init/plan/apply afin de voir un exemple de déploiement.

> ne pas oublier de faire un terraform destroy après avoir fait des tests

## Providers

| Name | Version |
|------|---------|
| [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) | >= 3.11, < 4.0 |


## Resources provisionés

| Name | Type |
|------|------|
| [azurerm_windows_virtual_machine_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [azurerm_linux_virtual_machine_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_orchestrated_virtual_machine_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/orchestrated_virtual_machine_scale_set) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vmss_mode | Scale 'uniform' ou 'flexible' | `string` | "uniform" | no |
| os_type | OS déployé lors de la création de scale set 'uniform' | `string`| "windows" | no |
| resourcegroup_name | Resource group name | `string` | null | yes |
| location | région de déploiement des ressources | `string` | null | yes |
| virtual_machine_password | Mot de passe des VMs du scale set | `string` | "" | no |
| vmss_name | Nom du VMSS | `string` | null | yes |
| vm_size | Taille des VMs du VMSS | `string` | "Standard_B2s" | no |
| os_disk_caching | OS disk cache | `string` | "readWrite | no |
| os_disk_type | OS Disk type, peut être : 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS', 'StandardSSD_ZRS', 'Premium_ZRS' | `string` | "Standard_LRS" | no |
| [vm_image](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage) | Image reference | `map(any)` | <pre>{<br>  "publisher": "MicrosoftWindowsServer",<br>  "offer": "WindowsServer",<br>  "sku": "2019-Datacenter",<br>  "version": "latest"<br>}</pre> | no |
| custom_image_name | Nom de l'image customisée si besoin. (ATTENTION - Le module terraform ne supporte pas (encore) les image customisées en mode 'specialized') | `string` | "" | no |
| custom_image_gallery_name | Nom de la galerie de l'image customisée si besoin. (ATTENTION - Le module terraform ne supporte pas (encore) les image customisées en mode 'specialized') | `string` | "" | no |
| custom_image_name_resource_group | resource group de l'image customisée si besoin. | `string` | "" | no |
| nb_instances | Nombre d'instances créées dans le scale set uniforme | `number` | 2 | no |
| rule | scale-in policy quelle VM sera supprimée sur le scale set doit réduire de resource horizontale. valeurs possibles : Default, NewestVM et OldestVM | `string` | "Default" | no |
| force_deletion_enabled | La Vm chosie pour la reduction de resource sera-t-elle supprimé de force ? (défault sur 'false') | `bool` | false | no |
| vnet_name | Nom du vnet dans lequel se trouvera le VMSS | `string` | null | yes |
| subnet_name | Nom du subnet dans lequel se trouvera le VMSS | `string` | null | yes |
| identity_type | VM Identity type, peut être : 'SystemAssigned', 'UserAssigned' ou 'SystemAssigned | `string` | "SystemAssigned" | no |
| tags | Map des tags par défaut du VMSS | `map(string)` | {} | no |
| zones | Zones de déploiement | `list(any)` | [] | no |
| single_placement_group | Single placement group. Les valeurs possibles sont: [false, true] | `bool` | false | no |
| zone_balance | Les machines virtuelles de ce groupe identique doivent-elles être strictement réparties uniformément dans les zones de disponibilité ? | `bool` | false | no |


## Outputs

| Name | Description |
|------|-------------|
| flexible_scale_set_id | Id du scale set flexible créé |
| uniform_windows_scale_set_id | Id du scale set uniforme windows créé |
| uniform_linux_scale_set_id | Id du scale set uniforme linux créé |
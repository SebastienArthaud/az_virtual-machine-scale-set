variable "vmss_mode" {
  type        = string
  description = "Scale 'uniform' ou 'flexible'"
  default     = "uniform"

  validation {
    condition     = contains(["flexible", "uniform"], var.vmss_mode)
    error_message = "The vmss_mode must be either 'flexible' or 'uniform'."
  }
}

variable "os_type" {
  type        = string
  description = "OS déployé lors de la création de scale set 'uniform'"
  default     = "windows"

  validation {
    condition     = contains(["windows", "linux"], var.os_type)
    error_message = "The os_type must be either 'windows' or 'linux'."
  }

}

variable "resourcegroup_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "région de déploiement des ressources"
}

variable "virtual_machine_password" {
  type        = string
  description = "VM password"
  default     = ""
}

variable "vmss_name" {
  type        = string
  description = "Nom du VMSS"
}


variable "vm_size" {
  type        = string
  description = "Taille des VMs du VMSS"
  default     = "Standard_B2s"
}

variable "os_disk_caching" {
  type        = string
  description = "OS Disk cache"
  default     = "ReadWrite"

  validation {
    condition     = contains(["ReadWrite", "ReadOnly ", "None"], var.os_disk_caching)
    error_message = "The os_disk_caching must be either 'ReadWrite', 'ReadOnly' or 'None'."
  }
}

variable "os_disk_type" {
  type        = string
  description = "OS Disk type, peut être : 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS', 'StandardSSD_ZRS', 'Premium_ZRS' "
  default     = "Standard_LRS"

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS ", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "UltraSSD_LRS"], var.os_disk_type)
    error_message = "The os_disk_type must be either 'Standard_LRS', 'StandardSSD_LRS', 'StandardSSD_ZRS', 'Premium_LRS', 'PremiumV2_LRS', 'Premium_ZRS', 'UltraSSD_LRS' or 'None'."
  }
}

variable "vm_image" {
  type        = map(any)
  description = "Image reference"
  default = {
    "publisher" : "MicrosoftWindowsServer"
    "offer" : "WindowsServer"
    "sku" : "2019-Datacenter"
    "version" : "latest"
  }
}

variable "custom_image_name" {
  type        = string
  description = "Nom de l'image customisée si besoin."
  default     = ""
}

variable "custom_image_gallery_name" {
  type        = string
  description = "Nom de la galerie de l'image customisée si besoin."
  default     = ""
}


variable "custom_image_name_resource_group" {
  description = "resource group de l'image customisée si besoin."
  type        = string
  default     = ""
}

variable "nb_instances" {
  type        = number
  description = "Nombre d'instances créées dans le scale set uniforme"
  default     = 2
}


variable "rule" {
  type        = string
  description = "scale-in policy quelle VM sera supprimée sur le scale set doit réduire de resource horizontale. valeurs possibles : Default, NewestVM et OldestVM"
  default     = "Default"

  validation {
    condition     = contains(["Default", "NewestVM ", "OldestVM"], var.rule)
    error_message = "The rule must be either 'Default', 'NewestVM', 'OldestVM'."
  }
}

variable "force_deletion_enabled" {
  type        = bool
  description = "La Vm chosie pour la reduction de resource sera-t-elle supprimé de force ? (défault sur 'false')"
  default     = false
}

variable "vnet_name" {
  type        = string
  description = "Nom du vnet dans lequel se trouvera le VMSS"
}

variable "subnet_name" {
  type        = string
  description = "Nom du subnet dans lequel se trouvera le VMSS"
}

variable "identity_type" {
  type        = string
  description = "VM Identity type, peut être : 'SystemAssigned', 'UserAssigned' ou 'SystemAssigned"
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned ", "SystemAssigned"], var.identity_type)
    error_message = "The identity_type must be either 'SystemAssigned', 'UserAssigned', 'SystemAssigned'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Map des tags par défaut du VMSS"
  default     = {}
}

variable "zones" {
  type        = list(any)
  description = "Zones de déploiement"
  default     = []
}

variable "single_placement_group" {
  type        = bool
  default     = false
  description = "Single placement group. Les valeurs possibles sont: [false, true]"
}


variable "zone_balance" {
  type        = bool
  description = "Les machines virtuelles de ce groupe identique doivent-elles être strictement réparties uniformément dans les zones de disponibilité ?"
  default     = false
}

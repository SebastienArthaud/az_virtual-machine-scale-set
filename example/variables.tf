variable "vm_resourcegroup_name" {
  description = "Resource group de la vm créée"
  type        = string
}

variable "name" {
  description = "Nom de vm créée"
  type        = string
}

variable "subnet_name" {
  description = "nom du subnet associé"
  type        = string
}

variable "vnet_name" {
  description = "nom du vnet associé"
  type        = string
}


variable "location" {
  type        = string
  description = "Resource group name"
}

variable "custom_image_name" {
  type        = string
  description = "Nom de l'image customisée si besoin. (La variable vm_image devient alors nulle)"
}

variable "custom_image_gallery_name" {
  type        = string
  description = "Nom de la galerie de l'image customisée si besoin."
}

variable "nb_instances" {
  type        = number
  description = "Nombre d'instances à créer"
}
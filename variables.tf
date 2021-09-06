variable "location" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "bastion_subnet_cidr" {
  type = string
}

variable "dns_subnet_cidr" {
  type = string
}

variable "dns_lb_ip_address" {
  type = string
}

variable "vm_image_id" {
  type = string
}

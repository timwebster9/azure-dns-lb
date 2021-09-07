location = "uksouth"

vnet_address_space  = "10.0.0.0/16"
bastion_subnet_cidr = "10.0.0.64/26"
dns_subnet_cidr     = "10.0.0.128/26"

dns_lb_ip_address   = "10.0.0.132"

vm_image_id = "/subscriptions/2ca65474-3b7b-40f2-b242-0d2fba4bde6e/resourceGroups/mgmt-rg/providers/Microsoft.Compute/galleries/policytestsig/images/ubuntu-bind9/versions/0.0.5"
////////////////GLOBAL VARIABLES////////////////
variable "subscription_id" {
    type = string
    description = "Subscription ID for the resources"
    default = "58c8b0cc-c111-41ac-9537-28f1ada835b1"  
}



variable "rgName" {
    type = string
    description = "Name for the resource group"
    default = "rg-dns-eastus-prod"  
}

variable "location" {
    type = string
    description = "Location for the resources"
    default = "eastus"
}

variable "environment" {
    type = string
    default = "prod"
}

variable "tags" {
    type = map(string)
    default = {
      "costCenter" = "value"
      "productName" = "DNS Forwarder"
      "environment" = "prod"
    }

}
////////////////VIRTUAL NETWORK / NIC VARIABLES////////////////


variable "private_ip_address" {
    type = string
    default = "10.251.4.7"
}



////////////////VIRTUAL MACHINE VARIABLES////////////////


variable "prefix" {
  default = "AZTNVM09"
}

variable "subnet_id" {
    type = string
    description = "Subnet for VM Nic"
    default = "/subscriptions/61f88854-232c-4985-a80d-305faa003457/resourceGroups/RG-NETWORKING-EASTUS1/providers/Microsoft.Network/virtualNetworks/vnet-networking/subnets/snet-adds-eastus"
}

variable "admin_username" {
    type = string
    description = "Admin username"
    default = "tnlocaladmin" 
}



/*
////////////////SERVICE PRINCIPAL VARIABLES////////////////
*/

variable "appId" {
    type = string
    description = "Password for admin"
    default = "2de8eef8-4304-4b59-bbc8-f75058d276c0"
}

variable "client_certificate_path" {
    type = string
    description = "Path to the pfx file"
}

variable "client_certificate_password" {
    type = string
}
/* //Uncomment this block if you authenticate service principal with secret.

variable "client_secret" {
    type = string
    description = "Password for admin"
    default = ""
  
}
*/



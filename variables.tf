////////////////GLOBAL VARIABLES////////////////
variable "subscription_id" {
    type = string
    description = "Subscription ID for the resources"
    default = "6e3758e4-4e0e-493c-a76c-30062288219a"  
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
    default = "C:\\OpenSSL\\bin\\infra-service-principal.pfx"
}

/* //Uncomment this block if you authenticate service principal with secret.

variable "client_secret" {
    type = string
    description = "Password for admin"
    default = "kBe7Q~HgxaGqMZAYGppUWSBrwxLd2BQadVi69"
  
}
*/



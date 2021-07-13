# Azure GUIDS
variable "subscription_id" {
    
}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {
    description = "TENANT_ID"
    default = "2b6e2a8e-d207-4d68-b800-dfba94a7a609"
}
    
# Resource Group/Location
variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default = "francecentral"
}
variable "resource_group" {
    description = "Name of resources groups"
    default = "ensure_quality_rg"
}
variable "application_type" {}

# Network
variable virtual_network_name {}
variable address_prefix_test {}
variable address_space {}


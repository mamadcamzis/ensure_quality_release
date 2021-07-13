provider "azurerm" {
  tenant_id       = var.tenant_id
  features {}
}
terraform {
  backend "azurerm" {
    #resource_group_name  = "${var.resource_group}"
    storage_account_name = "tfrance50"
    container_name       = "tfrance"
    key                  = "terraform.tfrance"
    access_key           = "ismmmI2cwsmAFZukxInDiNNFfZ8o55zDiB0ahbm7ZKNdP8R9bVfaJBhqt/2y3WZa5x+LAI/2KHvK8KcPO+uLNw=="
  }
}
module "resource_group" {
  source               = ".//modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
}
module "network" {
  source               = ".//modules/network"
  address_space        = var.address_space
  location             = var.location
  virtual_network_name = var.virtual_network_name
  application_type     = var.application_type
  resource_type        = "VNET"
  resource_group       = module.resource_group.resource_group_name
  address_prefix_test  = var.address_prefix_test
}

module "nsg-test" {
  source           = ".//modules/networksecuritygroup"
  location         = var.location
  application_type = var.application_type
  resource_type    = "NSG"
  resource_group   = module.resource_group.resource_group_name
  subnet_id        = module.network.subnet_id_test
  address_prefix_test = var.address_prefix_test
}
module "appservice" {
  source           = ".//modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = module.resource_group.resource_group_name
}
module "publicip" {
  source           = ".//modules/publicip"
  location         = var.location
  application_type = var.application_type
  resource_type    = "publicip"
  resource_group   = module.resource_group.resource_group_name
}


module "virtual_machine" {
  source               = ".//modules/vm"
  location             = var.location
  resource_group       = module.resource_group.resource_group_name
  application_type     = var.application_type
  resource_type        = "VM"

  public_ip_address_id = module.publicip.public_ip_address_id
  public_subnet_id     = module.network.subnet_id_test
  admin_username       = "adminuser"

}
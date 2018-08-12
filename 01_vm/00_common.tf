provider "azurerm" {}

locals {
  vmlist = ["o1", "k1", "s1", "s2"]
}

variable "resource_location" {
  default = "japanwest"
}

variable "custom_script_storage_account" {}
variable "custom_script_storage_access_key" {}
variable "custom_script_base_uri" {}

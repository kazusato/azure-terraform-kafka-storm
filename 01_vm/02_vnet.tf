resource "azurerm_virtual_network" "kafka_storm_vnet" {
  address_space = ["10.0.0.0/16"]
  location = "${var.resource_location}"
  name = "kafka_storm_vnet"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
}
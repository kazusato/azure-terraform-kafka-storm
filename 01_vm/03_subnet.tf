resource "azurerm_subnet" "kafka_storm_main_subnet" {
  address_prefix = "10.0.0.0/24"
  name = "kafka_storm_main_subnet"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.kafka_storm_vnet.name}"
}
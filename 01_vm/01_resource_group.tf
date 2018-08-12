resource "azurerm_resource_group" "kafka_storm_rg" {
  location = "${var.resource_location}"
  name = "kafka_storm_rg"
}
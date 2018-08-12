resource "azurerm_public_ip" "kafka_storm_oper_public_ip" {
  location = "${var.resource_location}"
  name = "kafka_storm_oper_public_ip"
  public_ip_address_allocation = "dynamic"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
}
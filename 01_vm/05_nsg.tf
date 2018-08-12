resource "azurerm_network_security_group" "kafka_storm_oper_nsg" {
  location = "${var.resource_location}"
  name = "kafka_storm_oper_nsg"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
  security_rule {
    access = "Allow"
    direction = "Inbound"
    name = "SSH"
    priority = 1001
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}
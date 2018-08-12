resource "azurerm_network_interface" "kafka_storm_nic" {
  count = "${length(local.vmlist)}"

  "ip_configuration" {
    name = "kafka_storm_${element(local.vmlist, count.index)}_nic_config"
    private_ip_address_allocation = "dynamic"
    subnet_id = "${azurerm_subnet.kafka_storm_main_subnet.id}"
    public_ip_address_id = "${element(local.vmlist, count.index) == "o1" ? azurerm_public_ip.kafka_storm_oper_public_ip.id : ""}"
  }
  location = "${var.resource_location}"
  name = "kafka_storm_nic_${element(local.vmlist, count.index)}"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
  network_security_group_id = "${element(local.vmlist, count.index) == "o1" ? azurerm_network_security_group.kafka_storm_oper_nsg.id : ""}"
}
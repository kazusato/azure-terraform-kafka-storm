resource "azurerm_virtual_machine_extension" "kafka_storm_vm_extension" {
  count = "${length(local.vmlist)}"

  location = "${var.resource_location}"
  name = "kst_vm_${element(local.vmlist, count.index)}"
  publisher = "Microsoft.Azure.Extensions"
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
  type = "CustomScript"
  type_handler_version = "2.0"
  virtual_machine_name = "${element(azurerm_virtual_machine.kafka_storm_vm.*.name, count.index)}"
  protected_settings = <<SETTINGS
    {
        "fileUris": ["${var.custom_script_base_uri}custom-script/update-install-yums-kafka-storm.sh"],
        "commandToExecute": "sh update-install-yums-kafka-storm.sh",
        "storageAccountName": "${var.custom_script_storage_account}",
        "storageAccountKey": "${var.custom_script_storage_access_key}"
    }
SETTINGS
}

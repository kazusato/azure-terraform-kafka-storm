resource "azurerm_virtual_machine" "kafka_storm_vm" {
  count = "${length(local.vmlist)}"

  location = "${var.resource_location}"
  name = "kst_vm_${element(local.vmlist, count.index)}"
  network_interface_ids = ["${element(azurerm_network_interface.kafka_storm_nic.*.id, count.index)}"]
  resource_group_name = "${azurerm_resource_group.kafka_storm_rg.name}"
  "storage_os_disk" {
    create_option = "FromImage"
    name = "kst_vm_${element(local.vmlist, count.index)}_os_disk"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.3"
    version = "latest"
  }
  os_profile {
    admin_username = "kstadmin"
    computer_name = "kst${element(local.vmlist, count.index)}"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/kstadmin/.ssh/authorized_keys"
      key_data = "${file("nogit/id_rsa.pub")}"
    }
  }
  boot_diagnostics {
    enabled = true
    storage_uri = "${azurerm_storage_account.kakfa_storm_storage_account.primary_blob_endpoint}"
  }
  vm_size = "Standard_D2_v3"
}
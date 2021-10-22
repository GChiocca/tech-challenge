locals {
  vm_image_publisher = "MicrosoftWindowsServer"
  vm_image_offer     = "WindowsServer"
  vm_secret          = "clngvm"
  vm_local_admin     = "clngvmadmin"
  env_short = {
      "UK South" = "uks"
  }
  name        = "${var.appname}-${var.environment}-${lookup(local.env_short, var.location)}"
  vm_name_prefix = "${var.appname}${lookup(local.env_short, var.location)}"
}
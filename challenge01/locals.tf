locals {
  vm_secret      = "clngvm"
  vm_local_admin = "clngvmadmin"
  loc_short = {
    "UK South" = "uks"
  }
  name           = "${var.appname}-${var.environment}-${lookup(local.loc_short, var.location)}"
  vm_name_prefix = "${var.appname}${var.environment}${lookup(local.loc_short, var.location)}"
}
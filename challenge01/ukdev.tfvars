location    = "UK South"
appname     = "clng"
environment = "dev"
vm_app = {
  count = 2
  size  = "Standard_B2ms"
}
vm_web = {
  count = 2
  size  = "Standard_B2ms"
}
vm_sql = {
  count = 2
  size  = "Standard_B2ms"
}
vnet = {
  address_space = "10.0.0.0/26"
  subnets = {
    web = {
      subnet = "10.0.0.0/28"
    },
    app = {
      subnet = "10.0.0.16/28"
    },
    sql = {
      subnet = "10.0.0.32/28"
    }
  }
}

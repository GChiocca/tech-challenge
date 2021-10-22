location    = "UK South"
appname     = "clng"
environment = "prd"
vm_app      = {
  count = 2
  size = "Standard_B2ms"
}
vm_web      = {
  size = "Standard_B2ms"
}
vm_sql     = {
  size = "Standard_B2ms"
}
vnet = {
  address_space = "10.1.0.0/26"
  subnets = {
    web = {
      subnet = "10.1.0.0/28"
    },
    app = {
      subnet = "10.1.0.16/28"
    },
    sql = {
      subnet = "10.1.0.32/28"
    }
  }
}

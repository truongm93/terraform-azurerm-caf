
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}


resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"
  }
}
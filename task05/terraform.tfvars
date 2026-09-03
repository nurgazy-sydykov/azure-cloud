resource_groups = {
  rg1 = {
    name     = "cmaz-3o15j4kj-mod5-rg-01"
    location = "West Europe"
  },
  rg2 = {
    name     = "cmaz-3o15j4kj-mod5-rg-02"
    location = "North Europe"
  },
  rg3 = {
    name     = "cmaz-3o15j4kj-mod5-rg-03"
    location = "East US"
  }
}

app_service_plans = {
  asp1 = {
    name         = "cmaz-3o15j4kj-mod5-asp-01"
    sku          = "S1"
    worker_count = 2
    rg_key       = "rg1"
  },
  asp2 = {
    name         = "cmaz-3o15j4kj-mod5-asp-02"
    sku          = "S1"
    worker_count = 1
    rg_key       = "rg2"
  }
}

app_services = {
  app1 = {
    name    = "cmaz-3o15j4kj-mod5-app-01"
    rg_key  = "rg1"
    asp_key = "asp1"
  },
  app2 = {
    name    = "cmaz-3o15j4kj-mod5-app-02"
    rg_key  = "rg2"
    asp_key = "asp2"
  }
}

traffic_manager = {
  name           = "cmaz-3o15j4kj-mod5-traf"
  routing_method = "Performance"
}

# -------------------------
# IP Restrictions
# -------------------------
#allowed_ip          = "18.153.146.156"
#allowed_service_tag = "AzureTrafficManager"
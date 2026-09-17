resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku                 = "Standard"

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name   = "app"
    image  = "${var.acr_login_server}/${var.image_name}:latest"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_hostname_secret
      REDIS_PWD = var.redis_primary_key_secret
    }
  }

  ip_address_type = "Public"
  dns_name_label  = var.aci_name

  tags = var.tags
}

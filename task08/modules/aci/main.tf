resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"

  image_registry_credential {
    server   = var.acr_login_server
    username = "admin"   # using admin creds since ACR admin_enabled = true
    password = ""        # Terraform will inject automatically if admin_enabled
  }

  container {
    name   = "app"
    image  = "${var.acr_login_server}/${var.image_name}:latest"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 80
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
  ports {
	port     = 80
	protocol = "TCP"
  }

  tags = var.tags
}

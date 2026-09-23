resource "kubectl_manifest" "secret_provider_class" {
  yaml_body = templatefile("${path.root}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = var.aks_kv_access_identity_id
    kv_name                    = var.kv_name
    redis_url_secret_name      = var.redis_url_secret_name
    redis_password_secret_name = var.redis_password_secret_name
    tenant_id                  = var.tenant_id
  })

  depends_on = [var.aks_depends_on]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.root}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = var.acr_login_server
    app_image_name   = var.app_image_name
    image_tag        = var.image_tag
  })

  depends_on = [
    var.aks_depends_on,
    kubectl_manifest.secret_provider_class
  ]

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.root}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [
    kubectl_manifest.deployment,
    var.aks_depends_on
  ]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [
    kubectl_manifest.service,
    var.aks_depends_on
  ]
}

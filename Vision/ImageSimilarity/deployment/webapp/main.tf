terraform {
  backend "azurerm" {
    storage_account_name = "secondstorageaccountneha"
    container_name = "secondcontainer"
    key = ""
    resource_group_name = "testing-powerskill"
  }
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.30"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ml" {
  location = var.location
  name     = var.resource_group
}

resource "azurerm_app_service_plan" "appserviceplan" {
  location            = var.location
  resource_group_name = var.resource_group

  name     = "mlappserviceplan"
  kind     = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "P2V2"
  }
}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
  number  = false
}

resource "azurerm_app_service" "dockerapp" {
  location            = var.location
  resource_group_name = var.resource_group

  name                = "extraction${random_string.random.result}"
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 5000
    DOCKER_REGISTRY_SERVER_URL          = var.docker_registry_url
    DOCKER_REGISTRY_SERVER_USERNAME     = var.docker_registry_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.docker_registry_password
    DEBUG                               = var.debug
    RESOURCE_GROUP                      = var.resource_group
    IMAGE_FEATURES_FILE                 = var.image_features_file
    TOPN                                = var.topn
    KEY                                 = "YourSecretKeyCanBeAnything"
  }

  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}

#COMMENT these out if you already have an azure cognitive search and service account
# resource "azurerm_search_service" "my_ACS_instance" {
#   name                = "[Name your service instance]" # Can choose on your own and needs to be unique
#   resource_group_name = var.resource_group
#   location            = var.location
#   sku                 = "standard"
# }

# resource "azurerm_cognitive_account" "my_cog_service_instance" {
#   name                = "[Name your service instance]" # Can choose on your own and needs to be unique
#   location            = var.location
#   resource_group_name = var.resource_group
#   kind                = "Face"

#   sku_name = "S0"

#   tags = {
#     Acceptance = "Test"
#   }
# }


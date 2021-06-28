variable "app_service_sku" {
  description = "The SKU (size - cpu/mem) of the app plan hosting the container. See: https://azure.microsoft.com/en-us/pricing/details/app-service/linux/"
  default = "P2V2"
}

variable "docker_registry_url" {
  default= "secondcontainerregistry.azurecr.io"
}

variable "docker_registry_username" {
  default = "secondcontainerregistry"
}

variable "docker_registry_password" {
  default = "sP7fF8Qljl6D1P6FN+YcAWRDZ6rIb46p"
}

variable "docker_image" {
  description = "[your docker image name]:[your tag]"
  default =  "secondcontainerregistry.azurecr.io/image_similarity_extractor:attempt_9"
}

variable "resource_group" {
  description = "testing-powerskill"
  default = "testing-powerskill"
}

variable "location" {
  description = "eastus2"
  default = "eastus2"
}

variable "debug" {
  description = "API logging - set to True for verbose logging"
  default = true
}

variable "image_features_file" {
  description = "Set this to stanford_dogs.pkl (if using demo value)"
  default = "stanford_dogs.pkl"
}

variable "topn" {
  description = "Number of similar images to return"
  default = "3"
}

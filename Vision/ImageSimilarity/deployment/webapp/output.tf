
#COMMENT these out if you already have a azure cognitive search and service account
output "search_service_primary_key"{
    value = azurerm_search_service.my_ACS_instance.primary_key
}
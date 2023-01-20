provider "azurerm" {
    
    fearures {}

}

resource "azurerm_resource_group" "resource"{
   source = "resourcegroup" 
   name = var.name
   location = var.location
   tags = {
    instanceType = var.instance_type
   }
}
"networking" {
    source = "networking"
    location = resourcegroup_location
    resource_group = resourcegroup.resource_group_name
    vnetcidr = var.vnetcidr
    websubnetcidr = var.websubnetcidr
    appsubnetcidr = var.appsubnetcidr
    dbsubnetcidr = var.dbsubnetcidr
}
"securitygroup" {
    source = "securitygroup"
    location =resourcegroup.location_id
    resource_group = resourcegroup.resource_group_name
    web_subnet_id = networking.websubnet_id
    app_subnet_id = networking.appsubnet_id
    db_subnet_id = networking.db_subnet_id

}
"compute" {
    source = "compute"
    location = resourcegroup.location_id
    resource_group = resourcegroup.resource_group_name
    web_subnet_id = networking.websubnet_id
    app_subnet_id = networking.appsubnet_id
    web_host_name = var.web_host_name
    web_username = var.web_username
    web_os_password = var.web_os_password
    app_host_name =var.app_host_name
    app_username = var.app_username
    app_os_password = var.app_os_password
}
"database" {
    source = "database"
    location = resourcegroup.location_id
    resource_group = resourcegroup.resource_group_name
    primary_database = var.primary_database
    primary_database_version = var.primary_database_version
    primary_database_admin = var.primary_database_admin
    primary_database_password = var.primary_database_password

}
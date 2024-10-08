# Atlas Organization ID
variable "atlas_org_id" {
 type        = string
 description = "Atlas Organization ID"
}

# Atlas Project Name
variable "atlas_project_name" {
 type        = string
 description = "Atlas Project Name"
}

# Atlas Project Environment
 variable "environment" {
   type        = string
   description = "The environment to be built"
}
 
# Cluster Instance Size Name
variable "cluster_instance_size_name" {
 type        = string
 description = "Cluster instance size name"
}

# Cloud Provider to Host Atlas Cluster
variable "cloud_provider" {
 type        = string
 description = "AWS or GCP or Azure"
}

# Atlas Region
variable "atlas_region" {
 type        = string
 description = "Atlas region where resources will be created"
}

# MongoDB Version
variable "mongodb_version" {
 type        = string
 description = "MongoDB Version"
}


# Create a Project
resource "mongodbatlas_project" "atlas-project" {
 org_id = var.atlas_org_id
 name = var.atlas_project_name
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
 username = "${var.DB_USER}"
 password = "${var.DB_PASSWORD}"
 project_id = mongodbatlas_project.atlas-project.id
 auth_database_name = "admin"
 roles {
   role_name     = "readWriteAnyDatabase"
   database_name = "admin"
 }
}


resource "mongodbatlas_cluster" "test" {
 project_id                  = mongodbatlas_project.atlas-project.id
 name                        = "${var.atlas_project_name}-${var.environment}-cluster"
 cluster_type                = "REPLICASET"
 provider_name               = "TENANT"
 backing_provider_name       = var.cloud_provider
 provider_region_name        = var.atlas_region
 provider_instance_size_name = var.cluster_instance_size_name
}
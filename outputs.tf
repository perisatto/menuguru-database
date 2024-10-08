#outputs.tf
output "security_group_id" {
  value       = aws_security_group.rds_sg.id
}
output "db_instance_endpoint" {
  value       = aws_db_instance.menuguru.endpoint
}

output "cluster_name" {
 value = mongodbatlas_cluster.test.name
 description = "Name of the MongoDB Atlas cluster"
}

output "project_id" {
 value = mongodbatlas_cluster.test.project_id
 description = "ID of the MongoDB Atlas project where the cluster resides"
}

output "default_location" {
  value       = var.default_location
  description = "value of the default location"
}
output "project_name" {
  value       = var.project_name
  description = "value of the project name"
}

output "tenant_id" {
  value       = var.tenant_id
  description = "value of the tenant id"
}
output "tags" {
  value       = local.common_tags_processed
  description = "value of the tags"
}
output "environment" {
  value       = var.environment
  description = "value of the environment"
}

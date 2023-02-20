output "key_secret_version" {
  value     = data.google_secret_manager_secret_version.key_secret_version.secret_data
  sensitive = true
}
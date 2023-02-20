# resource "google_service_account" "demo_sa" {
#   account_id = "demo-service-account"
#   project    = "manifest-wind-374504"
# }

# resource "time_rotating" "sa_key_rotation" {
#   rotation_days = 5
# }

# resource "google_service_account_key" "demo_sa_key" {
#   service_account_id = google_service_account.demo_sa.name
#   public_key_type    = "TYPE_X509_PEM_FILE"
#   keepers = {
#     rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
#   }
# }

# resource "google_secret_manager_secret" "demo_secret" {
#   project   = "manifest-wind-374504"
#   secret_id = "demo_service_account_key_secret"
#   replication {
#     automatic = true
#   }
# }

# resource "google_secret_manager_secret_version" "key_secret_version" {
#   secret      = google_secret_manager_secret.demo_secret.id
#   secret_data = base64decode(google_service_account_key.demo_sa_key.private_key)
# }



data "google_secret_manager_secret_version" "key_secret_version" {
  secret  = "demo_service_account_key_secret"
  project = "manifest-wind-374504"
  # name = "projects/806990164553/secrets/demo_service_account_key_secret/versions/latest"

}
data "google_service_account" "demo_sa" {
  project = "manifest-wind-374504"
  account_id = "demo-service-account"
}

provider "google-beta" {
  credentials = jsonencode({
    client_email = "thotapraveenbabu@gmail.com",
    project      = "manifest-wind-374504"
    region       = "us-west2"
    private_key  = data.google_secret_manager_secret_version.key_secret_version.secret
  })
}
provider "google" {
  project = "manifest-wind-374504"
  # credentials = file(var.gcp_auth_file)
  region = "us-west2"
}
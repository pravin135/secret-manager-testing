# resource "local_file" "sa_json_file" {
#   content = base64decode(google_service_account_key.demo_sa_key.private_key)
#  filename = "${path.module}/demo_key.json"

# }
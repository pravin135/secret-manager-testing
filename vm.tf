resource "google_compute_network" "main" {
  name = "main"
  #   region                  = "us-west2"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1500
}
resource "google_compute_subnetwork" "private" {
  name          = "private"
  ip_cidr_range = "10.0.1.0/24"
  #   region                   = "us-west2"
  network                  = "main"
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = "10.0.2.0/24"
  # region                   = "us-west2"
  network                  = google_compute_network.main.self_link
  private_ip_google_access = true
}
resource "google_compute_router" "router" {
  name    = "quickstart-router"
  network = "main"
  region  = "us-west2"
}
resource "google_compute_router_nat" "nat" {
  name                               = "quickstart-router-nat"
  router                             = google_compute_router.router.name
  region                             = "us-west2"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-west2-a"
  tags         = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20221201"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  #scratch_disk {
  # interface = "SCSI"
  #}

  network_interface {
    network = "default"

    #access_config {
    # // Ephemeral public IP
    #  }
    # }

    #metadata = {
    # foo = "bar"
    #}

    # metadata_startup_script = "echo hi > /test.txt"
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.demo_sa.email
    scopes = ["cloud-platform"]
  }
}
resource "google_compute_firewall" "rules" {
  name        = "my-firewall-rule"
  network     = "main"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", ]
  }

  source_tags = ["foo"]
  target_tags = ["web"]
}
resource "google_compute_firewall" "rule1" {
  name        = "my-firewall-rule1"
  network     = "main"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_tags = ["foo"]
  target_tags = ["web"]
}


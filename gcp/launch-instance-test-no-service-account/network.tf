# create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.app_name}-vpc"
  auto_create_subnetworks = "false"
}

# create private subnet
resource "google_compute_subnetwork" "private_subnet_1" {
  name          = "${var.app_name}-${var.app_environment}-private-subnet-1"
  ip_cidr_range = var.private_subnet_cidr_1
  network       = google_compute_network.vpc.name
  region        = var.gcp_region_1
}

# create a router
resource "google_compute_router" "router" {
  name    = "${var.app_name}-${var.app_environment}-router"
  network = google_compute_network.vpc.name
}

# allow tcp from IAP
resource "google_compute_firewall" "allow-tcp-from-iap" {
  name    = "${var.app_name}-${var.app_environment}-fw-allow-tcp-from-iap"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "35.235.240.0/20"
  ]
}

# allow ssh to instance
resource "google_compute_firewall" "allow-ssh-to-instance" {
  name    = "${var.app_name}-${var.app_environment}-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]

  target_tags = ["ssh"]
}


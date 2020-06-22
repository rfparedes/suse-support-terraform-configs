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

# create a public ip for nat service
resource "google_compute_address" "nat_ip" {
  name    = "${var.app_name}-${var.app_environment}-nap-ip"
  project = var.app_project
  region  = var.gcp_region_1
}

# create a nat to allow private instances connect to internet
resource "google_compute_router" "nat-router" {
  name    = "${var.app_name}-${var.app_environment}-nat-router"
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "${var.app_name}-nat-gateway"
  router                             = google_compute_router.nat-router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ google_compute_address.nat_ip.self_link ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on                         = [ google_compute_address.nat_ip ]
}

# allow internal icmp
resource "google_compute_firewall" "allow-internal" {
  name    = "${var.app_name}-${var.app_environment}-fw-allow-internal"
  network = google_compute_network.vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "${var.private_subnet_cidr_1}"
  ]
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

# allow ssh to bastion
resource "google_compute_firewall" "allow-ssh-to-bastion" {
  name    = "${var.app_name}-${var.app_environment}-fw-allow-ssh-to-bastion"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]

  target_tags = ["bastion"]
}


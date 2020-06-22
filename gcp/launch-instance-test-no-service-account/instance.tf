# Create instance with service account
resource "google_compute_instance" "instance-1" {
  name         = "${var.app_name}-${var.app_environment}-instance-with-svc-account"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "suse-cloud/sles-15"
    }
  }

  metadata = {
    ssh-keys = "rich:${file("/home/rich/.ssh/id_rsa.pub")}"
  }

  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_1.name

    access_config {
    }
  }

  service_account {
    email = var.srv_acct
    scopes = []
  }
  allow_stopping_for_update = true
}

# Create instance without service account
resource "google_compute_instance" "instance-2" {
  name         = "${var.app_name}-${var.app_environment}-instance-without-svc-account"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "suse-cloud/sles-15"
    }
  }

  metadata = {
    ssh-keys = "rich:${file("/home/rich/.ssh/id_rsa.pub")}"
  }

  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_1.name

    access_config {
    }
  }
}


# show ip address of instance with service account
output "public_ip_address_with_service_acct" {
  value = google_compute_instance.instance-1.network_interface.0.access_config.0.nat_ip
  description = "The public ip address"
}

# show ip address of instance without service account
output "public_ip_address_without_service_account" {
  value = google_compute_instance.instance-2.network_interface.0.access_config.0.nat_ip
  description = "The public ip address"
}


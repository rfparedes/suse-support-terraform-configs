# Create sles-15-sp1-v20200415-working 
resource "google_compute_instance" "old-instance" {
  name         = "${var.app_name}-${var.app_environment}-working"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1

  boot_disk {
    initialize_params {
      image = "projects/suse-cloud/global/images/sles-15-sp1-v20200415"
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }
  
  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_1.name
  }
  service_account {
    email = var.srv_acct
    scopes = []
  }
  allow_stopping_for_update = true
} 

# Create sles-15-sp1-v20200610-notworking
resource "google_compute_instance" "new-instance" {
  name         = "${var.app_name}-${var.app_environment}-notworking"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1

  boot_disk {
    initialize_params {
      image = "projects/suse-cloud/global/images/sles-15-sp1-v20200610"
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_1.name
  }
  service_account {
    email = var.srv_acct
    scopes = []
  }
  allow_stopping_for_update = true
}

# Create bastion running new image to determine why this is only seen in CloudNAT
resource "google_compute_instance" "bastion-instance" {
  name         = "${var.app_name}-${var.app_environment}-bastion"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  tags         = ["bastion"]

  boot_disk {
    initialize_params {
      image = "projects/suse-cloud/global/images/sles-15-sp1-v20200610"
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
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

# show bastion ip address
output "bastion_ip_address" {
  value = google_compute_instance.bastion-instance.network_interface.0.access_config.0.nat_ip
  description = "The bastion public ip address"
}
output "working_private_ip" {
  value = google_compute_instance.old-instance.network_interface.0.network_ip
  description = "The private ip address of working instance"
}
output "non_working_private_ip" {
  value = google_compute_instance.new-instance.network_interface.0.network_ip
  description = "The private ip address of non-working instance"
}

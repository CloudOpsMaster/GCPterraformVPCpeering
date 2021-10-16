terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.12.0"
    }
  }
}



provider "google" {
  credentials = file(var.private_key_path)
  project     = "calm-library-264211"
}


resource "google_compute_instance" "ubuntu-a" {
  name         = "ubuntu-a"
  machine_type = "e2-small"
  tags = ["internal-a", "ssh"]
  zone        = "${var.region-a}-a"

  metadata_startup_script = file("${path.module}/scripts/init.sh")
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210720"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet-a.name
    network_ip = var.instance_a
  }
}




resource "google_compute_instance" "ubuntu-b" {
  name         = "ubuntu-b"
  machine_type = "e2-small"
  tags = ["internal-b", "ssh"]
  zone        = "${var.region-b}-b"

  metadata_startup_script = file("${path.module}/scripts/init.sh")
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210720"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet-b.name
    network_ip = var.instance_b
  }
}


resource "google_compute_firewall" "allow-internal-b" {
  name    = "vpc-fw-allow-internal-b"
  network = google_compute_network.vpc-b.name
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
  target_tags = ["internal"]
}

resource "google_compute_firewall" "web-b" {
  name        = "web-firewall-rule-b"
  network     = google_compute_network.vpc-b.name
  description = "Creates firewall rule for loadbalancer"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8111"]
  }
  target_tags = ["web"]
}


resource "google_compute_firewall" "allow-bastion-b" {
  name    = "fw-allow-bastion-b"
  network = google_compute_network.vpc-b.name
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
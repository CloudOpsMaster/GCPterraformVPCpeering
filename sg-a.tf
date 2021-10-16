
resource "google_compute_firewall" "allow-internal-a" {
  name    = "vpc-fw-allow-internal-a"
  network = google_compute_network.vpc-a.name
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

resource "google_compute_firewall" "web-a" {
  name        = "web-firewall-rule-a"
  network     = google_compute_network.vpc-a.name
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


resource "google_compute_firewall" "allow-bastion-a" {
  name    = "fw-allow-bastion-a"
  network = google_compute_network.vpc-a.name
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
resource "google_compute_network_peering" "peering-a-b" {
  name         = "peering-a-b"
  network      = google_compute_network.vpc-a.id
  peer_network = google_compute_network.vpc-b.id
}

resource "google_compute_network_peering" "peering-b-a" {
  name         = "peering-b-a"
  network      = google_compute_network.vpc-b.id
  peer_network = google_compute_network.vpc-a.id
}
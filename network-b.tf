resource "google_compute_network" "vpc-b" {
  name                    = "vpc-b"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private-subnet-b" {
  name                     = "private-subnet"
  ip_cidr_range            = var.private_cidr_b
  network                  = google_compute_network.vpc-b.self_link
  region                   = var.region-b
  private_ip_google_access = false
}



resource "google_compute_router" "router-b" {
  name    = "router-b"
  network = google_compute_network.vpc-b.name
  region                   = var.region-b
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_nat" "nat-b" {
  name                               = "router-nat-b"
  router                             = google_compute_router.router-b.name
  region                             = google_compute_router.router-b.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private-subnet-b.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

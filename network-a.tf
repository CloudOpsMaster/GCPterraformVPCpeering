resource "google_compute_network" "vpc-a" {
  name                    = "vpc-a"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private-subnet-a" {
  name                     = "private-subnet-a"
  ip_cidr_range            = var.private_cidr_a
  network                  = google_compute_network.vpc-a.self_link
  region                   = var.region-a
  private_ip_google_access = false
}



resource "google_compute_router" "router-a" {
  name    = "router-a"
  network = google_compute_network.vpc-a.name
  region                   = var.region-a
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_nat" "nat-a" {
  name                               = "router-nat"
  router                             = google_compute_router.router-a.name
  region                             = google_compute_router.router-a.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private-subnet-a.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

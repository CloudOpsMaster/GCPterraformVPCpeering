variable "private_key_path" {
  type      = string
  default   = "../calm-library.json"
  sensitive = true
}

variable "region" {
  type    = string
  default = "europe-west3"
}

variable "private_cidr_a" {
  type    = string
  default = "10.128.1.0/24"
}
variable "region-a" {
  type    = string
  default = "us-central1"
}

variable "private_cidr_b" {
  type    = string
  default = "10.132.1.0/24"
}

variable "region-b" {
  type    = string
  default = "europe-west1"
}


variable "instance_a" {
  type    = string
  default = "10.128.1.10"
}


variable "instance_b" {
  type    = string
  default = "10.132.1.10"
}

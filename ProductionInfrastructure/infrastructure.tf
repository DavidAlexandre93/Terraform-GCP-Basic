provider "google" {
  credentials = file("terraform_sa.json")
  project     = "alisson-187813"
  region      = "us-east1"
}

resource "google_compute_instance" "chapter8" {
  name         = "chapter8-instance"
  machine_type = "g1-small"
  zone         = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20200414"
    }
  }
  network_interface {
    network       = "default"
    access_config {
    }
  }

  metadata = {
    sshKeys = join("",["alisson:",file("id_rsa.pub")])
  }
}

output "name" {
  value = google_compute_instance.chapter8.name
}
output "size" {
  value = google_compute_instance.chapter8.machine_type
}
output "public_ip" {
  value = google_compute_instance.chapter8.network_interface[0].access_config[0].nat_ip
}
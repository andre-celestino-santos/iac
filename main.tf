provider "google" {
  credentials = jsondecode(var.gcp_credentials)
  project     = var.project_id
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "web_server" {
  name         = "html-server"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = ["http-server"]
}

resource "google_compute_firewall" "default-allow-http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "instance_ip" {
  value = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

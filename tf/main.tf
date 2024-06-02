#############################################################################
#                                LOCALS                                     #
#############################################################################
locals {
    region = "europe-southwest1"
    zone   = "europe-southwest1-a"
}

#############################################################################
#                                VARIABLES                                  #
#############################################################################


#############################################################################
#                                MAIN                                       #
#############################################################################
# crear vm
resource "google_compute_instance" "cloud_one_vm" {
  name        = "cloud-1"
  zone        = local.zone

  machine_type         = "f1-micro"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = {
    docker-up = "docker compose up"
  }
}
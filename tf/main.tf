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
    }
  }

  network_interface {
    network = "test-network" #TODO crearlas yo
    subnetwork = "test-subnet"

    access_config {
      // Ephemeral public IP
    }
  }

    metadata_startup_script = "cd srcs && docker compose up -d"
    # connection {
    #     type        = "ssh"
    #     user        =  "roberto.rodriguez@paack.co"
    #     private_key = file("~/.ssh/id_rsa")
    #     host        = self.network_interface[0].access_config[0].nat_ip
    #   }
    # provisioner "file" {
    #   source      = "../srcs"
    #   destination = "."
    # }
}

# Cloud storage bucket 

## Dont event need this this with file provisioner

resource "google_storage_bucket" "inception" {
  name          = "inception-${local.project_id}"
  location      = upper(local.region)
  project       = local.project_id
  force_destroy = true
}

# Fetch all files in the source directory
locals {
  files = fileset(local.source_dir, "**")
}

# Create a resource for each file in the source directory
resource "google_storage_bucket_object" "inception_files" {
  for_each = local.files

  name   = each.key
  source = "${local.source_dir}/${each.key}"
  bucket = google_storage_bucket.inception.name

  depends_on = [google_storage_bucket.inception]
}
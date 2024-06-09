terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.31.1"
    }
  }
}

provider "google" {
  project = "ply-platform-353b"
  region  = "europe-west1"
}
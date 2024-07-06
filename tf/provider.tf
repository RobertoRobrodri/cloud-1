terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.31.1"
    }
  }
}

provider "google" {
  project = "sanguine-line-428613-m2"
  region  = "europe-west1"
}
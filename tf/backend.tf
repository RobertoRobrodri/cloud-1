terraform {
  backend "gcs" {
    bucket  = "42-tf-states"
    prefix  = "terraform/state"
  }
}

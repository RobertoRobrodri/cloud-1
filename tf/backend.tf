terraform {
  backend "gcs" {
    bucket  = "tf-state"
  }
}

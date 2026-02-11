terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = "YOUR_GCP_PROJECT_ID"
  region  = "us-central1"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-practice-bucket-2026"
  location = "US"
}

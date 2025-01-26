provider "google" {
  region = "asia-south2"
  project = "de-gcp-201"  
}


# Create a new project
resource "google_project" "new_project" {
  name            = "DE Project"
  project_id      = "de-gcpp-201"  # Ensure this is globally unique
  billing_account = "01C199-5D99B9-8C1FB1"   # Replace with your billing account ID
  deletion_policy = "ABANDON"  # Ensure this is set correctly, not "PREVENT"
}

# Create a storage bucket in the new project
resource "google_storage_bucket" "new_bkt_tstst" {
  name     = "de-test-bkts"
  location = "US"
  project  = google_project.new_project.project_id  # Reference the new project ID
}

# Create a service account in the new project
resource "google_service_account" "new_sa_de" {
  account_id   = "de-test-sa"
  display_name = "My DE TEST Service Account"
  project      = google_project.new_project.project_id  # Reference the new project ID
}

# Assign IAM role to the service account
resource "google_project_iam_member" "new-sa-role" {
  project = google_project.new_project.project_id  # Reference the new project ID
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.new_sa_de.email}"
}


# Enable necessary APIs for the project
resource "google_project_service" "enabled_apis" {
  for_each = toset([
    "bigquery.googleapis.com",          # BigQuery API
    "composer.googleapis.com",          # Cloud Composer API
    "storage.googleapis.com",           # Cloud Storage API
    "iam.googleapis.com",               # IAM API
    "cloudresourcemanager.googleapis.com" # Resource Manager API
  ])
  project = google_project.new_project.project_id
 
  service = each.key
}


# Create a BigQuery dataset in the new project
resource "google_bigquery_dataset" "new-de-datast" {
  dataset_id = "de_test_ds"
  location   = "US"
  project    = google_project.new_project.project_id  # Reference the new project ID
}

# Create a Composer environment in the new project
resource "google_composer_environment" "my_composer_env" {
  name    = "de-airflow-test"
  project = google_project.new_project.project_id  # Reference the new project ID
  region  = "asia-south2"

  config {
    node_count = 3
    software_config {image_version = "composer-2.0.0-airflow-2.1.0"}
  }
}

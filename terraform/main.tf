provider "google" {
  region = "asia-south2"
}

# Create a new project
resource "google_project" "new_project" {
  name            = "DE Project"
  project_id      = "data-engineering-203610"  # Ensure this is globally unique
  billing_account = "01C199-5D99B9-8C1FB1"   # Replace with your billing account ID
  # Remove org_id or provide the correct organization ID if needed
}

# Create a storage bucket in the new project
resource "google_storage_bucket" "my_bucket" {
  name     = "de-test-bucket"
  location = "US"
  project  = google_project.new_project.project_id  # Reference the new project ID
}

# Create a service account in the new project
resource "google_service_account" "my_service_account" {
  account_id   = "de-test-sa"
  display_name = "My DE TEST Service Account"
  project      = google_project.new_project.project_id  # Reference the new project ID
}

# Assign IAM role to the service account
resource "google_project_iam_member" "sa_role" {
  project = google_project.new_project.project_id  # Reference the new project ID
  role    = "roles/your-desired-role"
  member  = "serviceAccount:${google_service_account.my_service_account.email}"
}

# Create a BigQuery dataset in the new project
resource "google_bigquery_dataset" "my_dataset" {
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

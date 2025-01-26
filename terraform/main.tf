provider "google" {
  project = "Data-Engineering-20361"
  region  = "asia-south2"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "de-test-bucket"
  location = "US"
}

resource "google_service_account" "my_service_account" {
  account_id   = "de-test-sa"
  display_name = "My DE TEST Service Account"
}

resource "google_project_iam_member" "sa_role" {
  project = "Data-Engineering-20361"
  role    = "roles/your-desired-role"
  member  = "serviceAccount:${google_service_account.my_service_account.email}"
}

resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "de_test_ds"
  location   = "US"
}

resource "google_composer_environment" "my_composer_env" {
  name   = "de-airflow-test"
  region = "asia-south2"

  config {
    node_count = 3
    software_config {image_version = "composer-2.0.0-airflow-2.1.0"}
  }
}

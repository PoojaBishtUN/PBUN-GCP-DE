provider "google" {
  region = "asia-south2"
  project = "de-gcp-201"  
}


# Create a new project
#resource "google_project" "new_project" {
 # name            = "DE Project"
  #project_id      = "de-gcp-201"  # Ensure this is globally unique
  #billing_account = "01C199-5D99B9-8C1FB1"   # Replace with your billing account ID
  #deletion_policy = "ABANDON"  # Ensure this is set correctly, not "PREVENT"
#}

# Enable necessary APIs for the project
#resource "google_project_service" "enabled_apis" {
#  for_each = toset([
#    "bigquery.googleapis.com",          # BigQuery API
#    "composer.googleapis.com",          # Cloud Composer API
#    "storage.googleapis.com",           # Cloud Storage API
#    "iam.googleapis.com",               # IAM API
#    "cloudresourcemanager.googleapis.com" # Resource Manager API
#  ])
#  project = google_project.new_project.project_id
 
#  service = each.key
#}



# Create a storage bucket in the new project
#resource "google_storage_bucket" "new_bkt_tstst" {
#  name     = "de-gcp-201"
#  location = "US"
 # project  = google_project.new_project.project_id  # Reference the new project ID
#  project = "de-gcp-201" 
#}
# Create a service account in the new project
#resource "google_service_account" "new_sa_de" {
#  account_id   = "de-test-sa"
#  display_name = "My DE TEST Service Account"
#  project      = "de-gcp-201"  # Reference the correct project ID
#}

# Assign IAM role to the service account
#resource "google_project_iam_member" "new_sa_role" {
#  role    = "roles/owner"
#  member  = "serviceAccount:${google_service_account.new_sa_de.email}"  # Correctly reference the email of the service account
#  project = "de-gcp-201"
#}

# Reference the existing service account (manually created)
data "google_service_account" "existing_sa" {
  account_id = "de-test-sa"  # Use the actual account ID of the manually created service account
  project    = "de-gcp-201"   # Specify the project where the service account exists
}

# Assign BigQuery Admin role to the service account for the BigQuery dataset
#resource "google_project_iam_member" "bigquery_admin" {
#  project = "de-gcp-201"
#  role    = "roles/bigquery.admin"
#  member  = "serviceAccount:${data.google_service_account.existing_sa.email}"  # Reference the existing service account's email
#}

# Create a BigQuery dataset in the new project
#resource "google_bigquery_dataset" "new-de-datast" {
#  dataset_id = "de_test_ds"
#  location   = "US"
#  #project    = google_project.new_project.project_id  # Reference the new project ID
#  project = "de-gcp-201" 
#}

# Assign Composer Admin role to the service account for the Composer environment
resource "google_project_iam_member" "composer_admin" {
  project = "de-gcp-201"
  role    = "roles/composer.admin"
  member  = "serviceAccount:${data.google_service_account.existing_sa.email}"  # Reference the existing service account's email
}





# Create Cloud Composer environment
resource "google_composer_environment" "my_composer_env" {
  name    = "de-airflow-test"
  project = "de-gcp-201"  # Use the correct project ID
  region  = "asia-south2"

  config {
    software_config {image_version = "composer-2.10.2-airflow-2.10.2"}

    workloads_config {
      # Define the machine type for the nodes
      scheduler {
        cpu = "1"  # Specify CPU for the scheduler node
        memory_gb = 4  # Specify memory in GB for the scheduler node
      }

      # Worker node configuration
      worker {
        cpu = "2"  # Specify CPU for worker nodes
        memory_gb = 8  # Specify memory in GB for worker nodes
      }

      # Web server configuration
      web_server {
        cpu = "1"  # Specify CPU for the web server node
        memory_gb = 4  # Specify memory in GB for the web server node
      }
    }
  }
}


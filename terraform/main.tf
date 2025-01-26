terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.19.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_storage_bucket" "streaming_project_bucket" {
  name     = var.bucket_name
  location = var.region
}

resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}

resource "google_pubsub_subscription" "subscription" {
  name  = var.subscription_name
  topic = google_pubsub_topic.topic.name
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = "dt_chat"
  location                    = "US"
  default_table_expirations = null
}


resource "google_bigquery_table" "Netflix_Category_Analysis_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Category_Analysis
  description = "This is a dynamically schema-inferred Netflix_Category_Analysis"
}

resource "google_bigquery_table" "Netflix_Regional_Analysis_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Regional_Analysis
  description = "This is a dynamically schema-inferred table"
}



resource "google_bigquery_table" "Netflix_Release_Trends_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Release_Trends
  description = "This is a dynamically schema-inferred table"
}

resource "google_bigquery_table" "Netflix_Duration_Transformation_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Duration_Transformation
  description = "This is a dynamically schema-inferred table"
}

resource "google_bigquery_table" "Netflix_Cast_And_Director_Insights_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Cast_And_Director_Insights
  description = "This is a dynamically schema-inferred table"
}

resource "google_bigquery_table" "Netflix_Content_Rating_Analysis_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Content_Rating_Analysis
  description = "This is a dynamically schema-inferred table"
}

resource "google_bigquery_table" "Netflix_Top_Producers_" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_Netflix_Top_Producers
  description = "This is a dynamically schema-inferred table"
}
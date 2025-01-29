
variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "project-id"
}

variable "region" {
  description = "The region for the resources"
  type        = string
  default     = "your-region"
}

variable "zone" {
  description = "The zone for the resources"
  type        = string
  default     = "your-zone"
}

variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
  default     = "your-bucket"
}

variable "topic_name" {
  description = "The name of the Pub/Sub topic"
  type        = string
  default     = "your-topic-name"
}

variable "subscription_name" {
  description = "The name of the Pub/Sub subscription"
  type        = string
  default     = "your-subscription-name"
}

variable "dataset_id" {
  description = "The ID of the BigQuery dataset"
  type        = string
  default     = "your-dataset-name"
}

variable "Source_table" {
  description = "The name of the BigQuery conversations table"
  type        = string
  default     = "D_Source"
}


variable "table_Netflix_Category_Analysis" {
  description = "The name of the BigQuery conversations table"
  type        = string
  default     = "D_Netflix_Category_Analysis"
}

variable "table_Netflix_Regional_Analysis" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Regional_Analysis"
}

variable "table_Netflix_Release_Trends" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Release_Trends"
}

variable "table_Netflix_Duration_Transformation" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Duration_Transformation"
}

variable "table_Netflix_Cast_And_Director_Insights" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Cast_And_Director_Insights"
}

variable "table_Netflix_Content_Rating_Analysis" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Content_Rating_Analysis"
}

variable "table_Netflix_Top_Producers" {
  description = "The name of the BigQuery orders table"
  type        = string
  default     = "D_Netflix_Top_Producers"
}


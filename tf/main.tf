

resource "google_logging_project_sink" "my-sink" {
  name = "backup-health-events"
  destination = "pubsub.googleapis.com/${google_pubsub_topic.topic.id}"
  unique_writer_identity = true
  filter = "resource.type=\"cloud_run_job\" AND resource.labels.job_name=\"backup-health-test\" AND jsonPayload.job_id:\"\""

}




resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}


resource "google_pubsub_topic_iam_member" "member" {
  project = google_pubsub_topic.topic.project
  topic = google_pubsub_topic.topic.name
  role = "roles/pubsub.publisher"
  member = "${google_logging_project_sink.my-sink.writer_identity}"
}


#gcf

resource "google_cloudfunctions_function" "function" {
  name        = "backuphealth-slack-notifications"
  runtime     = "python312"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  entry_point           = "main"
  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource = google_pubsub_topic.topic.id
  }
  environment_variables = {
    "SLACK_WEBHOOK_URL" = var.webhook_url
  }
}




resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "${path.module}/code/gcfcode.zip"
  depends_on = [ null_resource.code_archive ]
}



resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = "US"
}


resource "null_resource" "code_archive" {
  provisioner "local-exec" {
    working_dir = "${path.module}/code"
    command = "zip -r gcfcode.zip main.py requirements.txt"
  }
}
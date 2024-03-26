

resource "google_logging_project_sink" "my-sink" {
  name = "backup-health-events"
  destination = "pubsub.googleapis.com/${google_pubsub_topic.topic.id}"
  unique_writer_identity = true
  filter = "resource.type=\"cloud_run_job\" AND resource.labels.job_name=\"backup-health-test\" AND jsonPayload.job_id:\"\""

}

resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}


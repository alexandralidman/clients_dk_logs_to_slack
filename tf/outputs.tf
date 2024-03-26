output "log_sink_service_account" {
  value = google_logging_project_sink.my-sink.writer_identity
  description = "Log Sink writer identity. Give this user the Pubsub Publisher role on the Pub/Sub topic."
}

output "google_pubsub_topic_id" {
  value = google_pubsub_topic.topic.name
  description = "Pubsub topic name. Put this value in --trigger-resource flag when deploying the cloud function"
}
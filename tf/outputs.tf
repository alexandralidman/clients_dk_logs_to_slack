output "log_sink_service_account" {
  value = google_logging_project_sink.my-sink.writer_identity
}
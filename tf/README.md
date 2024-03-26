## Slack notifications for backup tester

### Creates:
- log sink with a filter based on the custom backup tester logs
- pub/sub topic 
- google storage bucket for cloud function code
- code archive in storage bucket
- cloud function 

### Prerequisites
- Prepare terraform.tfvars file in root

### Deploy:
- terraform init
- terraform apply
- Note the value of the output log_sink_service_account. Give this account the Pubsub Publisher role on the Pub/Sub topic.
- cd code
- Prepare and run the gcloud command:

gcloud functions deploy backuphealth-slack-notifications  --runtime python312  --entry-point main   --trigger-event providers/cloud.pubsub/eventTypes/topic.publish   --trigger-resource <pubsub topic name>  --set-env-vars SLACK_WEBHOOK_URL=<Slack webhook url>  --region us-central1




### Variables

| variable        | description                                                                                                                    | required | default value                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------- | ------------------------------------------------------------------------- |
| project         | id of the project              to deploy the service                            | required |                                                                           |
| topic_name         | name for the pubsub topic                         | Optional |   "backuphealth-slack-notifications"                                                                        |

## Slack notifications for backup tester

### Creates:
- log sink with a filter based on the custom backup tester logs
- pub/sub topic 
- google storage bucket for cloud function code
- code archive in storage bucket
- cloud function 

### Prerequisites
- Make sure zip is installed on your system
- Prepare terraform.tfvars file in root


### Deploy:
- terraform init
- terraform apply
- Note the value of the output log_sink_service_account. Give this account the Pubsub Publisher role on the Pub/Sub topic.



### Variables


| variable        | description                                                                                                                    | required | default value                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------- | ------------------------------------------------------------------------- |
| project         | id of the project              to deploy the service                            | required |                                                                           |
| region          | GCP region to deploy the service                                                                                               | required |                                                                           |
| bucket_name        | Name for the gcf bucket to keep the code                                                                                      | required |                                                                           |
| webhook_url | The URL of the Slack webhook | required |  
| topic_name | Name for Pub/Sub topic | optional  |  "backuphealth-slack-notifications"                                                                |

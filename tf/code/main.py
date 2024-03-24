import json
import os
from google.cloud.logging import DESCENDING, Client
import base64
import requests
from datetime import datetime


def main(event, context):
    pubsub_message = json.loads(base64.b64decode(event['data']).decode('utf-8')
)

    webhook_url = os.getenv("SLACK_WEBHOOK_URL")
    slack_message = {
        "text": f"Backup Tester job log {datetime.now()}: {pubsub_message["jsonPayload"]}"
    }
    response = requests.post(webhook_url, data=json.dumps(slack_message), headers={'Content-Type': 'application/json'})
    return response
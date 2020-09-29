#!/bin/bash

# if [ ! -z "$ENABLE_IAM_CRON" ]; then
# echo 'IAM cron not enabled. Set ENABLE_IAM_CRON to enable'
# exit 1
# fi

SLEEP_TIME_MINUTES=${IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES:-120m}

echo '* Sync to IAM * Exporting ENV Variables'

echo $SLEEP_TIME_MINUTES

export IAM_SERVER=$IAM_RUCIO_SYNC_SERVER

export IAM_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID

export IAM_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET


echo '* Sync to IAM * Initializing Loop'

while true; do
    python Utilities-and-Operations-Scripts/iam-rucio-sync/sync_iam_rucio.py
    echo '* Sync to IAM * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done
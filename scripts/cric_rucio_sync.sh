#!/bin/bash

# if [ ! -z "$ENABLE_CRIC_CRON" ]; then
# echo 'CRIC cron not enabled. Set ENABLE_CRIC_CRON to enable'
# exit 1
# fi

SLEEP_TIME_MINUTES=${CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES:-120m}

echo 'Initializing Sync to CRIC Loop'

while true; do
    python Utilities-and-Operations-Scripts/cric-rucio-sync/sync_cric_rucio.py
    echo 'Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done
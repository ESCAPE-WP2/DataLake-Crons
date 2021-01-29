#!/bin/bash

echo '* Sync to IAM * Exporting ENV Variables'

export IAM_SERVER=$IAM_RUCIO_SYNC_SERVER
export IAM_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID
export IAM_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET

echo '* Sync to IAM * Starting'

python3 Utilities-and-Operations-Scripts/iam-rucio-sync/sync_iam_rucio.py

echo '* Sync to IAM * Done!'
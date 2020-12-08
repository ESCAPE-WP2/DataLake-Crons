#!/bin/bash

echo '* Sync to IAM (Gridmap) * Exporting ENV Variables'

export IAM_SERVER=$IAM_RUCIO_SYNC_SERVER
export IAM_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID
export IAM_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET
export IAM_GRIDMAP_PATH=/var/www/html/index.html

echo '* Sync to IAM (Gridmap) * Starting'

python Utilities-and-Operations-Scripts/iam-gridmap-sync/generate_escape_gridmap.py

echo '* Sync to IAM (Gridmap) * Done!'
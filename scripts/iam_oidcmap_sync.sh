#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull
cd /scripts/

echo '* Sync to IAM (OIDCmap) * Exporting ENV Variables'

export IAM_SERVER=$IAM_RUCIO_SYNC_SERVER
export IAM_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID
export IAM_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET
export IAM_OUTPUT_PATH=/var/www/html/index.html

echo '* Sync to IAM (OIDCmap) * Starting'

python3 Utilities-and-Operations-Scripts/iam-oidcmap-sync/generate_escape_oidcmap.py

echo '* Sync to IAM (OIDCmap) * Done!'
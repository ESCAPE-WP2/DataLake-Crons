#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull
cd /scripts/

echo '* Sync to Rucio (XCache Authfile) * Exporting ENV Variables'

export OUTPUT_PATH=/var/www/html/index.html

echo '* Sync to Rucio (XCache Authfile) * Starting'

python3 Utilities-and-Operations-Scripts/xcache-rucio-sync/generate_xcache_authfile.py

echo '* Sync to Rucio (XCache Authfile) * Done!'
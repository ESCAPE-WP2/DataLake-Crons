#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
GIT_SSL_NO_VERIFY=true GIT_CURL_VERBOSE=1 git pull
cd /scripts/

echo '* Sync to CRIC * Starting'

python3 Utilities-and-Operations-Scripts/cric-rucio-sync/sync_cric_rucio.py

echo '* Sync to CRIC * Done!'
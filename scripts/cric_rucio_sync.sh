#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull
cd /scripts/

echo '* Sync to CRIC * Starting'

python3 Utilities-and-Operations-Scripts/cric-rucio-sync/sync_cric_rucio.py

echo '* Sync to CRIC * Done!'
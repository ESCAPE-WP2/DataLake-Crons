#!/bin/bash

cd /scripts/rucio-stats-dids
git pull origin main

echo '* Rucio Stats Probe DIDs * Starting'

python3 rucio_stats_probe_dids.py --push --url=http://monit-metrics:10012

echo '* Rucio Stats Probe DIDs * Done!'


#!/bin/bash

cd /scripts/rucio-stats-probe
git pull origin main
cd /scripts/

echo '* Rucio Stats Probe * Starting'

python3 /scripts/rucio-stats-probe/rucio_stats_probe.py --push --url=http://monit-metrics:10012

echo '* Rucio Stats Probe * Done!'
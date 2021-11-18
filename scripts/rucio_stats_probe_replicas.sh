#!/bin/bash

cd /scripts/rucio-stats-replicas
git pull origin main

echo '* Rucio Stats Probe Replicas * Starting'

python3 rucio_stats_probe_replicas.py --push --url=http://monit-metrics:10012

echo '* Rucio Stats Probe Replicas * Done!'
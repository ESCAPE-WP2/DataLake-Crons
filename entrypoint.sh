#!/bin/bash

echo "Generating Rucio CFG"
j2 /rucio.cfg.escape.j2 | sed '/^\s*$/d' > /opt/rucio/etc/rucio.cfg
#j2 /tmp/rucio.cfg.j2 | sed '/^\s*$/d' > /opt/rucio/etc/rucio.cfg

/bin/bash iam_rucio_sync.sh &
/bin/bash cric_rucio_sync.sh &
/bin/bash iam_gridmap_sync.sh &
/bin/bash rucio_produce_noise.sh &
/bin/bash gfal_sam.sh &
/bin/bash fts_datalake_test.sh &

sleep 5
/usr/sbin/httpd -k restart

sleep infinity
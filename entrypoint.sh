#!/bin/bash

echo "Generating Rucio CFG"
j2 /tmp/rucio.cfg.j2 | sed '/^\s*$/d' > /opt/rucio/etc/rucio.cfg

/bin/bash iam_rucio_sync.sh &
/bin/bash cric_rucio_sync.sh &

sleep infinity
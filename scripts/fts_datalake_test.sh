#!/bin/bash

SLEEP_TIME_MINUTES=${FTS_DATALAKE_TEST_SLEEP_TIME_MINUTES:-30m}

echo '* FTS Testing * Exporting ENV Variables (X509: ' $X509_USER_PROXY ' )'

echo $SLEEP_TIME_MINUTES

mkdir -p /scripts/temp_files_fts/
export FTS_LOCALPATH="/scripts/temp_files_fts/"

echo '* FTS Testing * Initializing Loop'

fts_testing(){
    export GFAL2_TIMEOUT=300
    export XRD_CONNECTIONWINDOW=$GFAL2_TIMEOUT
    export XRD_REQUESTTIMEOUT=$GFAL2_TIMEOUT
    export XRD_STREAMTIMEOUT=$GFAL2_TIMEOUT
    export XRD_TIMEOUTRESOLUTION=$GFAL2_TIMEOUT
    python fts_datalake_test.py -i conf/datalake_all_1mb.json --cleanup --exit
    python fts_datalake_test.py -i conf/datalake_all_1mb.json
    python fts_datalake_test.py -i conf/datalake_all_except_lapp_webdav_1000mb.json
}

while true; do
    cd /scripts/fts-analysis-datalake/
    fts_testing &
    echo '* FTS Testing * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done

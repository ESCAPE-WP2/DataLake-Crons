#!/bin/bash

SLEEP_TIME_MINUTES=${FTS_DATALAKE_TEST_SLEEP_TIME_MINUTES:-30m}

echo '* FTS Testing * Exporting ENV Variables (X509: ' $X509_USER_PROXY ' )'

echo $SLEEP_TIME_MINUTES

mkdir -p /scripts/temp_files_fts/
export FTS_LOCALPATH="/scripts/temp_files_fts/"

echo '* FTS Testing * Initializing Loop'

fts_testing(){
    python fts_datalake_test.py -i conf/datalake.json --cleanup --exit
    python fts_datalake_test.py -i conf/lapp_webdav.json
    python fts_datalake_test.py -i conf/datalake.json
}

while true; do
    cd /scripts/fts-analysis-datalake/
    fts_testing &
    echo '* FTS Testing * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done

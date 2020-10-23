#!/bin/bash

SLEEP_TIME_MINUTES=${GFAL_SAM_SLEEP_TIME_MINUTES:-2m}

echo '* Gfal SAM Testing * Exporting ENV Variables (X509: ' $X509_USER_PROXY ' )'

echo $SLEEP_TIME_MINUTES

mkdir -p /scripts/gfal_sam/
export GFAL_LOCALPATH="/scripts/gfal_sam/"

export CRIC_URL="http://escape-cric.cern.ch/api/doma/rse/query/?json&preset=doma"

echo '* Gfal SAM Testing * Initializing Loop'

while true; do
    cd $GFAL_LOCALPATH
    python /scripts/Utilities-and-Operations-Scripts/gfal-sam-testing/gfal_sam.py
    echo '* Gfal SAM Testing * Will sleep for ' $SLEEP_TIME_MINUTES
    sleep $SLEEP_TIME_MINUTES
done
#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull
cd /scripts/

echo '* Gfal SAM Testing * Exporting ENV Variables (X509: ' $X509_USER_PROXY ' )'

mkdir -p /scripts/gfal_sam/
export GFAL_LOCALPATH="/scripts/gfal_sam/"
export CRIC_URL="http://escape-cric.cern.ch/api/doma/rse/query/?json&preset=doma"

echo '* Gfal SAM Testing * Starting'

cd $GFAL_LOCALPATH
python3 /scripts/Utilities-and-Operations-Scripts/gfal-sam-testing/gfal_sam.py -i /scripts/Utilities-and-Operations-Scripts/cric-info-tools/disabled_rses.txt

echo '* Gfal SAM Testing * Done!'
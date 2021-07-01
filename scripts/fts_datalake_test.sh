#!/bin/bash

cd /scripts/fts-analysis-datalake/
GIT_SSL_NO_VERIFY=true git pull

echo '* FTS Testing * Exporting ENV Variables (X509: ' $X509_USER_PROXY ' )'
echo '* FTS Testing * Starting'

# python3 fts_datalake_test.py -i conf/datalake_all_1mb.json --cleanup --exit
# python3 fts_datalake_test.py -i conf/datalake_all_1mb.json

echo '* FTS Testing * Done!'

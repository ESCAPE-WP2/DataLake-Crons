# DataLake-Crons
> Synchronization Scripts

The container is used to periodically run specific operations in the ESCAPE DataLake.
The container runs the CRIC-Rucio, IAM-Rucio, and IAM-EOS gridmap synchronizations, as well as Rucio noise, gfal-sam-testing, and FTS TPC tests.
The original scripts can be found at https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts and https://github.com/ESCAPE-WP2/fts-analysis-datalake.git .

## Example of build and upload
```bash
docker build . --tag projectescape/escape-datalake-crons:release-1.25.6
```
Remember to do `docker login` and be member of `projectescape`.
```bash
docker push projectescape/escape-datalake-crons:release-1.25.6
```
## Run

The following `ENV` variables should be configured before running the container.
```bash
export RUCIO_CFG_DATABASE_DEFAULT=$RUCIO_CFG_DATABASE_DEFAULT
export IAM_RUCIO_SYNC_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET
export IAM_RUCIO_SYNC_SERVER=$IAM_RUCIO_SYNC_SERVER
export IAM_RUCIO_SYNC_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID
```
Optionally, set the following variables to control the frequency of the execution.
```bash    
export CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES=$CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES
export IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES=$IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES
```
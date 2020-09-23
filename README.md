# DataLake-Crons
> Synchronization Scripts

The container is used to periodically run specific operations in the ESCAPE DataLake.
At the moment, it runs the synchronization with CRIC and IAM services.
The original scripts can be found at https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts .

## Example of build and upload

    docker build .

    docker tag $IMAGE_ID projectescape/escape-datalake-crons:release-1.23.6

Remember to do `docker login` and be member of `projectescape`.

    docker push projectescape/escape-datalake-crons:release-1.23.6

## Run

The following `ENV` variables should be configured before running the container.

    export RUCIO_CFG_DATABASE_DEFAULT=$RUCIO_CFG_DATABASE_DEFAULT
    export IAM_RUCIO_SYNC_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET
    export IAM_RUCIO_SYNC_SERVER=$IAM_RUCIO_SYNC_SERVER
    export IAM_RUCIO_SYNC_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID

Optionally, set the following variables to control the frequency of the execution.
    
    export CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES=$CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES
    export IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES=$IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES
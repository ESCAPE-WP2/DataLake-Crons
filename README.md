# Container containing synchronization scripts with IAM-ESCAPE and ESCAPE-CRIC

This containers is used in the ESCAPE Datalake to run some operation periodically. At the moment it is running the synchronization with CRIC and IAM services. The original scripts can be found here https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts

## Configuring
The following env variables should be configured before while running the container

    $RUCIO_CFG_DATABASE_DEFAULT
    $IAM_RUCIO_SYNC_CLIENT_SECRET
    $IAM_RUCIO_SYNC_SERVER
    $IAM_RUCIO_SYNC_CLIENT_ID

You can also optionally set the following variable to control the frequency of the execution
    
    $CRIC_RUCIO_SYNC_SLEEP_TIME_MINUTES
    $IAM_RUCIO_SYNC_SLEEP_TIME_MINUTES

## Example build and upload
    $ docker build .

    $ docker tag 26150bcd1cdb frouk/escape_datalake_crons

    $ docker push frouk/escape_datalake_crons

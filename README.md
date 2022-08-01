# DataLake Synchronization & Testing Scripts

## General Information

The files in this repository build the container that is used to run periodically specific operations in the ESCAPE DataLake.

These operations concern synchronization routines:

* CRIC &#8594; Rucio RSEs configuration mapping ([source code](https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts/tree/master/cric-rucio-sync))

* IAM &#8594; Rucio accounts mapping ([source code](https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts/tree/master/iam-rucio-sync))

* IAM &#8594; EOS accounts mapping (gridmap file) ([source code](https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts/tree/master/iam-gridmap-sync))

as well as mock traffic production:

* Production of Rucio noise (upload + replicate) ([source code](https://github.com/ESCAPE-WP2/DataLake-Crons/blob/master/scripts/rucio_produce_noise.sh))

* GFAL testing (upload + download + delete) ([source code](https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts/tree/master/gfal-sam-testing))

* FTS testing (TPC transfers) ([source code](https://github.com/ESCAPE-WP2/fts-analysis-datalake))


## Example of build and upload

Every commit to the repo will trigger a CI/CD action which rebuilds the image and pushes it to https://hub.docker.com/u/projectescape, as specified in the .github/workflows/docker-image.yml file. The image will then be referenced in the K8s Cronjob specification in https://gitlab.cern.ch/escape-wp2/ew2c-kubernetes-cluster-configuration/-/tree/master/Crons (restricted access). 

If you want to run it manually: 

The build and push commands can be found inside the `Makefile`. 

The `baseimage` and `basetag` variables should be adjusted accordingly. In order to build and tag the new image one has to execute the following command:
```bash
make build 
```
In order to be able to push the newly built image, you would need to `docker login` first and also be a member of [projectescape](https://hub.docker.com/u/projectescape) DockerHub organizatiton. Then you can just execute:
```bash
make push
```
## Run

The following `ENV` variables should be configured before running the container.
```bash
export RUCIO_CFG_DATABASE_DEFAULT=$RUCIO_CFG_DATABASE_DEFAULT
export IAM_RUCIO_SYNC_CLIENT_SECRET=$IAM_RUCIO_SYNC_CLIENT_SECRET
export IAM_RUCIO_SYNC_SERVER=$IAM_RUCIO_SYNC_SERVER
export IAM_RUCIO_SYNC_CLIENT_ID=$IAM_RUCIO_SYNC_CLIENT_ID
```
To run the container and get an interactive terminal inside use:
```bash
make run
```
Note that this command will delete the container when you exit.

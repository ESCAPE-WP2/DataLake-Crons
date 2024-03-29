# base image details
baseimage = rucio/rucio-server
basetag = release-1.29.0
# target image details
imagetarget = projectescape/escape-datalake-crons
imagetag = $(basetag)
# rucio version to be used inside the container
rucio_version = 1.29.0

build:
# create image with two different tags, one for versioning and one as `stable`
	docker build . -f Dockerfile --build-arg BASEIMAGE=$(baseimage) --build-arg BASETAG=$(basetag) --build-arg RUCIO_VERSION=$(rucio_version) --pull --no-cache --tag $(imagetarget):$(imagetag) --tag $(imagetarget):stable

run:
	docker run --rm -it $(imagetarget):$(imagetag)

push:
# push both versioned and stable image
	docker push $(imagetarget):$(imagetag)
	docker push $(imagetarget):stable

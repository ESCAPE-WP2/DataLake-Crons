# base image details
baseimage = rucio/rucio-server
basetag = release-1.26.8
# target image details
imagetarget = projectescape/escape-datalake-crons
imagetag = $(basetag)

build:
	docker build . -f Dockerfile --build-arg BASEIMAGE=$(baseimage) --build-arg BASETAG=$(basetag) --pull --no-cache --tag $(imagetarget):$(imagetag)

run:
	docker run --rm -it $(imagetarget):$(imagetag)

push:
	docker push $(imagetarget):$(imagetag)

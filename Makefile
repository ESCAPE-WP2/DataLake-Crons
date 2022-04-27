# base image details
baseimage = rucio/rucio-server
basetag = release-1.26.11
# target image details
imagetarget = projectescape/escape-datalake-crons
imagetag = $(basetag)

build:
# create image with two different tags, one for versioning and one as `stable`
	docker build . -f Dockerfile --build-arg BASEIMAGE=$(baseimage) --build-arg BASETAG=$(basetag) --pull --no-cache --tag $(imagetarget):$(imagetag) --tag $(imagetarget):stable

run:
	docker run --rm -it $(imagetarget):$(imagetag)

push:
# push both versioned and stable image
	docker push $(imagetarget):$(imagetag)
	docker push $(imagetarget):stable

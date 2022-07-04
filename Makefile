APPNAME = sampleapp
SHELL = bash
VERSION := $(shell git describe --tags 2> /dev/null || echo notag)

all: build run

build:
	docker build -f Dockerfile -t $(APPNAME)/$(VERSION) .

run:
	docker rm --force sampleapp 2> /dev/null
	docker run --detach --restart=always -p 8000:3838 --name $(APPNAME) $(APPNAME)/$(VERSION)

clean: clean-container clean-image

clean-container:
	docker rm --force sampleapp 2> /dev/null

clean-image:
	docker image rm --force $(APPNAME)/$(VERSION)

stop:
	docker container stop $(APPNAME)

start:
	docker container start $(APPNAME)

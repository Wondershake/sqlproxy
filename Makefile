PROJECT ?= $(shell gcloud config get-value project)
VERSION := $(shell cat VERSION)

.PHONY: all
all:
	make gce-proxy

.PHONY: gce-proxy
gce-proxy:
	docker build -f Dockerfile.gce-proxy-1.11 -t gcr.io/$(PROJECT)/prockiller:$(VERSION)-gce-proxy-1.11 .
	docker push gcr.io/$(PROJECT)/prockiller:$(VERSION)-gce-proxy-1.11

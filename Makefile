PROJECT ?= $(shell gcloud config get-value project)

.PHONY: sqlproxy
sqlproxy:
	docker build -f Dockerfile -t gcr.io/$(PROJECT)/sqlproxy:1.13 .
	docker push gcr.io/$(PROJECT)/sqlproxy:1.13

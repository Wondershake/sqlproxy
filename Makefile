VERSION := 1.13

.PHONY: push
push: build
	docker tag gcr.io/ws-wonderbase/sqlproxy:$(VERSION) gcr.io/wsdev-wonderbase/sqlproxy:$(VERSION)
	docker push gcr.io/ws-wonderbase/sqlproxy:$(VERSION)
	docker push gcr.io/wsdev-wonderbase/sqlproxy:$(VERSION)

.PHONY: build
build:
	docker build -f Dockerfile -t gcr.io/ws-wonderbase/sqlproxy:$(VERSION) .

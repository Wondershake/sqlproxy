FROM nownabe/watchkiller:1.1 AS watchkiller

FROM gcr.io/cloudsql-docker/gce-proxy:1.20.2

COPY --from=watchkiller /watchkiller /watchkiller


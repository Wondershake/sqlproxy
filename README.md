Cloud SQL Proxy with watchkiller
================================

# Usage

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: myjob
spec:
  backoffLimit: 0
  template:
    metadata:
      name: myjob
    spec:
      restartPolicy: Never
      volumes:
        - name: watchkiller
          emptyDir: {}
      containers:
        - name: myjob
          image: gcr.io/my-project/myjob:latest
          command: ["/bin/bash", "-c"]
          args:
            - |
              trap "touch /tmp/watchkiller/completed" EXIT
              /myjob
          volumeMounts:
            - name: cloudsql-instance-credentials
              mountPath: /secrets/cloudsql
              readOnly: true
            - name: watchkiller
              mountPath: /tmp/watchkiller

        - name: cloudsql-proxy
          image: gcr.io/my-project/sqlproxy:1.11
          command:
            - "/watchkiller"
            - "/cloud_sql_proxy"
            - "-instances=my-project:asia-northeast1:mydb=tcp:3306"
            - "-credential_file=/secrets/cloudsql/credentials.json"
          volumeMounts:
            - name: cloudsql-instance-credentials
              mountPath: /secrets/cloudsql
              readOnly: true
            - name: watchkiller
              mountPath: /tmp/watchkiller
          env:
            - name: KILLER_WATCH_FILE
              value: /tmp/watchkiller/completed
            - name: KILLER_INTERVAL
              value: "1"
```


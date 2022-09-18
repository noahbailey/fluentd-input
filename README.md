# Fluentd Input

Exposes a one-way queue for writing data into OpenSearch without exposing the entire database to the internet. This also acts as a buffer to protect against data loss if OpenSearch has temporary connectivity issues. 

By default, a secure Forward runs on port 5000/tcp using TLS.

## Configuration variables

Variable name | Example
--- | ---
`CERT_PATH` | /etc/ssl/certs/ssl-cert-snakeoil.pem
`CERT_KEY` | /etc/ssl/private/ssl-cert-snakeoil.key
`OPENSEARCH_HOST` | opensearch.example.com

## Docker-compose example

```yml
  fluentd-input:
    image: ghcr.io/noahbailey/fluentd-input/fluentd-input:latest
    container_name: fluentd-input
    ports:
      - 5000:5000
    environment: 
      OPENSEARCH_HOST: opensearch-node1
      CERT_PATH: /ssl-cert-snakeoil.pem
      KEY_PATH: /ssl-cert-snakeoil.key
    networks: 
      - opensearch-net
    volumes:
      - /etc/ssl/certs/ssl-cert-snakeoil.pem:/ssl-cert-snakeoil.pem
      - /etc/ssl/private/ssl-cert-snakeoil.key:/ssl-cert-snakeoil.key
```

## Client config

Any fluentbit or fluentd instance can forward their data to this service. 

```ini
[OUTPUT]
    Name          forward
    Match         logs.*
    Host          logs.mycoolserver.com
    Port          5000
    tls           on
    tls.verify    off
```

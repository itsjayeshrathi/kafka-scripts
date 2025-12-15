#!/usr/bin/env bash 
set -euo pipefail 

KAFKA_CONTAINER=kafka-1
KAFKA_BIN=/bin
BOOTSTRAP_SERVER=kafka-1:9092

docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-topics \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --describe \
    --topic products.prices.changelog \
| tr '\t' ' '  | column -t 
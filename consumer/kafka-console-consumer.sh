#!/usr/bin/env bash
set -euo pipefail

KAFKA_CONTAINER=kafka-1
KAFKA_BIN=/bin
BOOTSTRAP_SERVER=kafka-1:9092

docker exec "$KAFKA_CONTAINER" \
  "$KAFKA_BIN/kafka-console-consumer" \
  --bootstrap-server "$BOOTSTRAP_SERVER" \
  --topic products.prices.changelog.keys \
  #--from-beginning 
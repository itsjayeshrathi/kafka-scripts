#!/usr/bin/env bash
# set -euo pipefail

# KAFKA_CONTAINER=kafka-1
# KAFKA_BIN=/bin
# BOOTSTRAP_SERVER=kafka-1:9092

# docker exec -it "$KAFKA_CONTAINER" bash -c \
#   "$KAFKA_BIN/kafka-console-producer \
#    --bootstrap-server $BOOTSTRAP_SERVER \
#    --topic products.prices.changelog"

set -euo pipefail

KAFKA_CONTAINER=kafka-1
KAFKA_BIN=/bin
BOOTSTRAP_SERVER=kafka-1:9092

docker exec -it "$KAFKA_CONTAINER" bash -c \
  "$KAFKA_BIN/kafka-console-producer \
   --bootstrap-server $BOOTSTRAP_SERVER \
   --topic products.prices.changelog.keys \
   --property parse.key=true \
   --property key.separator=:"

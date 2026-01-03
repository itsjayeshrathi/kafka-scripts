#!/usr/bin/env bash 
set -euo pipefail 



docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN/kafka-server-stop" \
    "kafka-2" \
    --bootstrap-server "$BOOTSTRAP_SERVER"

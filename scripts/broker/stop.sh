#!/usr/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config/kafka.env"

docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN/kafka-server-stop" \
    "kafka-2" \
    --bootstrap-server "$BOOTSTRAP_SERVER"

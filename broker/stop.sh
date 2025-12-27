#!/usr/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config/kafka.env"

VAR=3

docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN/kafka-broker-stop" \
    "$VAR" \
    --bootstrap-server "$BOOTSTRAP_SERVER"

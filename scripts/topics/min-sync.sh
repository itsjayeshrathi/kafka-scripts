#!/usr/bin/env bash 
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/config/kafka.env"

docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN/kafka-topics" \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --create \
    --topic products.prices.changelog.min-isr-3 \
    --replication-factor 3 \
    --partitions 3 \
    --config min.insync.replicas=2
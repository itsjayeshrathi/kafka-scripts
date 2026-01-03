#!/usr/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config/kafka.env"

docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-topics \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --describe \
    --topic products.prices.changelog.min-isr-3 \
| tr '\t' ' '  | column -t 
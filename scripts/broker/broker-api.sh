#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../common/env.sh"

docker exec "$KAFKA_CONTAINER" \
  "$KAFKA_BIN"/kafka-broker-api-versions \
  --bootstrap-server "$BOOTSTRAP_SERVER"

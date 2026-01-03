#!/user/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/config/kafka.env"

docker exec "$KAFKA_CONTAINER" \
  "$KAFKA_BIN/kafka-console-consumer" \
  --bootstrap-server "$BOOTSTRAP_SERVER" \
  --topic products.prices.changelog.multi-partitions-keys \
  --group products \
  --from-beginning \
  --property print.key=true \
  --property key.separator=":"
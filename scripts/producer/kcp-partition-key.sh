#!/user/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/config/kafka.env"

docker exec -it "$KAFKA_CONTAINER" bash -c "
$KAFKA_BIN/kafka-console-producer \
  --bootstrap-server $BOOTSTRAP_SERVER \
  --topic products.prices.changelog.multi-partitions-keys \
  --property parse.keys=true \
  --property key.separator=':'
"
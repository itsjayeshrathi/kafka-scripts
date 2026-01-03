#!/user/bin/env bash 
set -euo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config/kafka.env"

# [all] - [0] - [-1] 
docker exec -it "$KAFKA_CONTAINER" bash -c \
"$KAFKA_BIN/kafka-console-producer \
    --bootstrap-server $BOOTSTRAP_SERVER \
    --topic products.prices.changelog.min-isr-3 \
    --producer-property acks=all" 
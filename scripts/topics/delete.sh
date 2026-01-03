#!/usr/bin/env bash 
set -euo pipefail 

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"
source "$(dirname "$0")/../common/kafka.sh"

: "${TOPIC:?TOPIC is required}"

kafka_topics --delete --topic "$TOPIC"
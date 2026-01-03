#!/usr/bin/env bash 
set -euo pipefail 

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"
source "$(dirname "$0")/../common/kafka.sh"

kafka_topics --describe --topic "$TOPIC" \
| tr '\t' ' '  | column -t 
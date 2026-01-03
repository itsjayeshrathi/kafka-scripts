#!/usr/bin/env bash
set -euo pipefail 

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"
source "$(dirname "$0")/../common/producer.sh"

: "${TOPIC:?TOPIC is required}"

producer \
    --topic "$TOPIC" \
    ${ACKS:+--producer-property acks="$ACKS"} \
    ${PARSE_KEYS:+--property parse.keys="$PARSE_KEYS"} \
    ${KEY_SEPARATOR:+--property key.separator="$KEY_SEPARATOR"}
#!/usr/bin/env bash
set -euo pipefail 

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"
source "$(dirname "$0")/../common/consumer.sh"

: "${TOPIC:?TOPIC is required}"

consumer \
    --topic "$TOPIC"
    ${GROUP_ID:+--group "$GROUP_ID"} \
    ${FROM_BEGINNING:+--from-beginning} \
    ${PRINT_KEY:+--property print.key=true} \
    ${KEY_SEPARATOR:+--property key.separator="$KEY_SEPARATOR"}
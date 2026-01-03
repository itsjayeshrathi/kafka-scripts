#!/usr/bin/env bash 
set -euo pipefail 

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"
source "$(dirname "$0")/../common/kafka.sh"

: "${TOPIC:?TOPIC is required}"
: "${REPLICATION_FACTOR:?REPLICATION_FACTOR is required}"
: "${PARTITIONS:?PARTITIONS is required}"

kafka_topics \
  --create \
  --topic "$TOPIC" \
  --partitions "${PARTITIONS}" \
  --replication-factor "${REPLICATION_FACTOR}" \
  ${MIN_ISR:+--config min.insync.replicas="$MIN_ISR"} \
  ${CLEANUP_POLICY:+--config cleanup.policy="$CLEANUP_POLICY"} \
  ${RETENTION_MS:+--config retention.ms="$RETENTION_MS"}

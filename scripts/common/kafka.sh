#!/usr/bin/env bash

kafka_topics() {
  docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-topics \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    "$@"
}

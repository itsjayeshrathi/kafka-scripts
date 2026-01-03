#!/usr/bin/env bash

producer() {
  docker exec -it "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-console-producer \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    "$@"
}

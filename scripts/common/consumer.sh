#!/usr/bin/env bash 

consumer(){
    docker exec "$KAKFA_CONTAINER" \
    "$KAFKA_BIN"/kafka-console-consumer \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    "$@"
}
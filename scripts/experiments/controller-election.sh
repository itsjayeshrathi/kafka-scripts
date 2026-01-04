#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../common/env.sh"
source "$(dirname "$0")/../common/validate.sh"

echo
echo "Controller Re-Election"

echo 
echo "Getting metadata quorum"
docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-metadata-quorum \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    describe --status 

echo 
read -r -p "Note LeaderID above. Press Enter to continue..."

echo 
echo "Finding current controller leader..."

LEADER_ID=$(docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-metadata-quorum \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    describe --status \
    | grep LeaderId | awk '{print $2}')

echo "Current Controller LeaderId = $LEADER_ID"

LEADER_CONTAINER="kafka-$LEADER_ID"

echo
echo "Stopping controller leader -> $LEADER_CONTAINER"
docker stop "$LEADER_CONTAINER"

echo
echo "Sleeping 10 seconds to allow re-election.."
sleep 10 

echo 
echo "Describe quorum after failure"
docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-metadata-quorum \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    describe --status

echo 
echo "Showing logs from surviving broker"
docker logs "$KAFKA_CONTAINER" --tail=50

echo 
read -r -p "Press Enter to restart stopped broker..."

echo
echo "Restarting old leader -> $LEADER_CONTAINER"
docker start "$LEADER_CONTAINER"

sleep 10

echo 
echo "Final quorum state"
docker exec "$KAFKA_CONTAINER" \
    "$KAFKA_BIN"/kafka-metadata-quorum \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    describe --status 

echo 
echo "Re-election complete"
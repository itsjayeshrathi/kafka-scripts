docker exec kafka \
    /opt/kafka/bin/kafka-topics.sh \
    --bootstrap-server localhost:9092 \
    --create \
    --topic products.prices.changelog \
    --partitions 1 \
    --replication-factor 1
docker exec kafka \
    /opt/kafka/bin/kafka-topics.sh \
    --bootstrap-server localhost:9092 \
    --create \
    --topic products.prices.changelog \
    --partitions 2\
    --replication-factor 2
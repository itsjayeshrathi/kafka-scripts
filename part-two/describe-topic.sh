docker exec kafka \
    /opt/kafka/bin/kafka-topics.sh \
    --bootstrap-server localhost:9092 \
    --describe \
    --topic products.prices.changelog \
| tr '\t' ' '  | column -t 
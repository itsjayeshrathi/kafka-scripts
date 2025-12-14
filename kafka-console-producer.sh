docker exec -it kafka bash -c \
  '/opt/kafka/bin/kafka-console-producer.sh \
   --bootstrap-server localhost:9092 \
   --topic products.prices.changelog'
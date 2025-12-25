SHELL := /bin/bash

KAFKA_CONTAINER := kafka
BOOTSTRAP := localhost:9092
TOPIC ?= products.prices.changelog

.PHONY: list describe create produce consume

create:
	bash topic/create.sh 

create-multi-partition:
	bash topics/multi-partition.sh

create-min-in-sync: 
	bash topics/min-sync.sh

describe:
	bash topics/describe-topic.sh

list:
	bash topics/list.sh

delete:
	bash topics/delete-topic.sh

add-partition:
	bash topics/add-partition.sh

produce:
	bash producer/kafka-console-producer.sh

consume:
	bash consumer/kafka-console-consumer.sh

produce-key: 
	bash producer/producer-partition-key.sh

consume-key:
	bash consumer/consumer-partition-key.sh

broker-api:
	bash broker/broker-api.sh

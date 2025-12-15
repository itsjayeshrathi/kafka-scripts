SHELL := /bin/bash

KAFKA_CONTAINER := kafka
BOOTSTRAP := localhost:9092
TOPIC ?= products.prices.changelog

.PHONY: list describe create produce consume

create:
	bash topic/create.sh 

produce:
	bash part-one/kafka-console-producer.sh

consume:
	bash part-one/kafka-console-consumer.sh

describe:
	bash part-two/describe-topic.sh

list:
	bash topic/

delete:
	bash part-two/delete-topic.sh

broker-api:
	bash part-two/broker-api.sh

add-partition:
	bash part-two/add-partition.sh

add-key:
	bash part-two/add-key.sh
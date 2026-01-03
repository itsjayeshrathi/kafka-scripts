SHELL := /bin/bash

PROJECT := kafka-scripts

# base paths
SCRIPTS_DIR := scripts
BROKER_DIR  := $(SCRIPTS_DIR)/broker
TOPICS_DIR  := $(SCRIPTS_DIR)/topics
PROD_DIR    := $(SCRIPTS_DIR)/producer
CONS_DIR    := $(SCRIPTS_DIR)/consumer

# docker file
DOCKER_DIR := docker
COMPOSE_FILE := $(DOCKER_DIR)/docker-compose.yml

# kafka config
KAFKA_CONTAINER := kafka
BOOTSTRAP       := localhost:9092
TOPIC          ?= products.prices.changelog

# phony targets
.PHONY: \
	create create-multi-partition create-min-in-sync \
	describe list delete add-partition \
	produce produce-ack produce-key \
	consume consume-ack consume-key \
	broker-api broker-stop

# topics
create:
	bash $(TOPICS_DIR)/create.sh

create-multi-partition:
	bash $(TOPICS_DIR)/multi-partition.sh

create-min-in-sync:
	bash $(TOPICS_DIR)/min-sync.sh

describe:
	bash $(TOPICS_DIR)/describe.sh

list:
	bash $(TOPICS_DIR)/list.sh

delete:
	bash $(TOPICS_DIR)/delete.sh

add-partition:
	bash $(TOPICS_DIR)/add-partition.sh

# producer
produce:
	bash $(PROD_DIR)/kafka-console-producer.sh

produce-ack:
	bash $(PROD_DIR)/kcp-ack.sh

produce-key:
	bash $(PROD_DIR)/producer-partition-key.sh

# consumer
consume:
	bash $(CONS_DIR)/kafka-console-consumer.sh

consume-ack:
	bash $(CONS_DIR)/kcc-ack.sh

consume-key:
	bash $(CONS_DIR)/consumer-partition-key.sh

# broker
broker-api:
	bash $(BROKER_DIR)/broker-api.sh

broker-stop:
	bash $(BROKER_DIR)/stop.sh

# docker
up:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) up -d

down:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) down

down-clean:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) down -v

ps:
	docker compose -p $(PROJECT) ps
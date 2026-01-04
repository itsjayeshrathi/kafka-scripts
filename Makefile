SHELL := /bin/bash

PROJECT := kafka-scripts

# paths
SCRIPTS_DIR := scripts
BROKER_DIR  := $(SCRIPTS_DIR)/broker
TOPICS_DIR  := $(SCRIPTS_DIR)/topics
PROD_DIR    := $(SCRIPTS_DIR)/producer
CONS_DIR    := $(SCRIPTS_DIR)/consumer
EXPERIMENT_DIR := $(SCRIPTS_DIR)/experiments

# docker
DOCKER_DIR := docker
COMPOSE_FILE := $(DOCKER_DIR)/docker-compose.yml

# defaults
TOPIC ?= products.prices.changelog

.PHONY: \
	up down down-clean ps \
	create describe list delete \
	produce consume \
	broker-api

# docker
up:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) up -d

up-log:
	docker compse -p $(PROJECT) -f $(COMPOSE_FILE) up

down:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) down

down-clean:
	docker compose -p $(PROJECT) -f $(COMPOSE_FILE) down -v

ps:
	docker compose -p $(PROJECT) ps

# topics
create:
	bash $(TOPICS_DIR)/create.sh

describe:
	TOPIC=$(TOPIC) bash $(TOPICS_DIR)/describe.sh

list:
	bash $(TOPICS_DIR)/list.sh

delete:
	TOPIC=$(TOPIC) bash $(TOPICS_DIR)/delete.sh

# producer
produce:
	TOPIC=$(TOPIC) bash $(PROD_DIR)/produce.sh

# consumer
consume:
	TOPIC=$(TOPIC) bash $(CONS_DIR)/consume.sh

# broker
broker-api:
	bash $(BROKER_DIR)/broker-api.sh

# experiments
election:
	bash $(EXPERIMENT_DIR)/controller-election.sh
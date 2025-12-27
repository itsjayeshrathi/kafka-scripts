package main

import (
	"context"
	"log"

	"github.com/confluentinc/confluent-kafka-go/v2/kafka"
)

func main() {

	p, err := kafka.NewProducer(&kafka.ConfigMap{
		"bootstrap.servers":  "localhost:9092,localhost:9093,localhost:9094",
		"acks":               "all",
		"enable.idempotence": true,
		"transactional.id":   "transaction-1",
		"partitioner":        "murmur2_random",
	})

	if err != nil {
		panic(err)
	}

	defer p.Close()

	ctx := context.Background()

	if err := p.InitTransactions(ctx); err != nil {
		log.Fatal("Initializing failed:", err)
	}

	if err := p.BeginTransaction(); err != nil {
		log.Fatal("BeginTransaction failed:", err)
	}

	topic := "customer.balance"

	err = p.Produce(&kafka.Message{
		TopicPartition: kafka.TopicPartition{
			Topic:     &topic,
			Partition: kafka.PartitionAny,
		},
		Key:   []byte("bob"),
		Value: []byte("-10"),
	}, nil)

	if err != nil {
		p.AbortTransaction(ctx)
		log.Fatal(err)
	}

	err = p.Produce(&kafka.Message{
		TopicPartition: kafka.TopicPartition{
			Topic:     &topic,
			Partition: kafka.PartitionAny,
		},
		Key:   []byte("alice"),
		Value: []byte("+10"),
	}, nil)

	if err != nil {
		p.AbortTransaction(ctx)
		log.Fatal(err)
	}

	if err := p.CommitTransaction(ctx); err != nil {
		log.Fatal("CommitTransaction Failed:", err)
	}

	// Wait for message deliveries before shutting down
	p.Flush(15 * 1000)
}

package main

import (
	"fmt"
	"log"

	"github.com/confluentinc/confluent-kafka-go/v2/kafka"
)

func main() {
	p, err := kafka.NewProducer(&kafka.ConfigMap{
		"bootstrap.servers":  "localhost:9092,localhost:9093,localhost:9094",
		"acks":               "all",
		"enable.idempotence": true,
		"partitioner":        "murmur2_random",
	})

	if err != nil {
		panic(err)
	}

	defer p.Close()

	topic := "products.prices.changelog"
	c := make(chan kafka.Event)
	err = p.Produce(&kafka.Message{
		TopicPartition: kafka.TopicPartition{
			Topic:     &topic,
			Partition: kafka.PartitionAny,
		},
		Key:   []byte("bob"),
		Value: []byte("2"),
	}, c)

	if err != nil {
		log.Fatal(err)
	} else {
		fmt.Printf("response from chan: %s\n", <-c)
	}
	p.Flush(15 * 10000)
}

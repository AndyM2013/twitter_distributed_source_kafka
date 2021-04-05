#!/bin/bash

# 1) Source connectors
# Start kafka cluster
docker-compose up kafka-cluster
# It may take ~2 minutes for the kafka cluster to be started


###############
# TwitterSourceConnector in distributed mode:
# Access landoop fast-data-dev root 
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash

# Create kafka topics
kafka-topics --create --topic distributed_twitter_data --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Start a console consumer on that topic
kafka-console-consumer --topic distributed_twitter_data --bootstrap-server 127.0.0.1:9092

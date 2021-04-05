# Disctributed Twitter Data Using Kafka

This project is about using Kafka to build a pipeline to ingest data from Twitter in real-time and sinks to PostgreSQL. These data can be used for a variety of interesting things. I will make updates in the future. 

* Using GraphQL to show the data changes in a dashboard.
* Building a real-time sentiment analysis
* Finding a way to convert nested user data which is a json format from Twitter API, then we could use Neo4j to create a social network map for community detection and centrality analysis
 
OK, let's take a look at how to retrieve distributed data from Twitter.

First, creating a Kafka cluster and postgres using the docker-compose.yaml file with command:
```
docker-compose up kafka-cluster postgres
```
The docker-compose.yaml file looks like:
```
version: '2'

services:
  # kafka cluster.
  kafka-cluster:
    image: landoop/fast-data-dev:cp3.3.0
    environment:
      ADV_HOST: 127.0.0.1         
      RUNTESTS: 0                 # Disable Running tests so the cluster starts faster
    ports:
      - 2181:2181                 # Zookeeper
      - 3030:3030                 # Landoop UI
      - 8081-8083:8081-8083       # REST Proxy, Schema Registry, Kafka Connect ports
      - 9581-9585:9581-9585       # JMX Ports
      - 9092:9092                 # Kafka Broker


  # postgres as sink with configuration
  postgres:
    image: postgres:9.5-alpine
    environment:
      POSTGRES_USER: postgres     # define credentials
      POSTGRES_PASSWORD: postgres # define credentials
      POSTGRES_DB: postgres       # define database
    ports:
      - 5432:5432                 # Postgres port
```
Landoop is an awesome Kafka UI platform where you could easily monitor your Kafka. https://hub.docker.com/r/landoop/fast-data-dev/

Next, let's access landoop inside docker.

```
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
```
Under the root account, we could set up our kafka topic and kafka consumer.
```
# TwitterSourceConnector in distributed mode:
# Access landoop fast-data-dev as root 
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
```
```
# Create kafka topics
kafka-topics --create --topic distributed_twitter_data --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
```
```
# Start a console consumer on that topic
kafka-console-consumer --topic distributed_twitter_data --bootstrap-server 127.0.0.1:9092
```
Now, it is time to take a look at the Landoop UI. The main page is looks like:

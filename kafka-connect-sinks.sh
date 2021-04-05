#!/bin/bash

# Source connectors
# Start kafka cluster
docker-compose up kafka-cluster postgres
# Wait 2 minutes for the kafka cluster to be started
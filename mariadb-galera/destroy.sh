#!/bin/bash

mode=$1

if [[ -z "$mode" || "$mode" == "compose" ]]; then
  echo "Using docker compose..."
  docker-compose -f docker-compose.yaml -p galera down -v

elif [[ "$mode" == "swarm" ]]; then
  export $(cat .env) > /dev/null 2>&1;
  echo -e "Stack Name\t= ${1:-$STACK_NAME}";
  echo ""
  docker stack rm ${1:-$STACK_NAME}
fi
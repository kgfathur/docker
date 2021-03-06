#!/bin/bash

mode=$1

# synchronize template
# ../rsync-src.sh
if [[ -z "$mode" || "$mode" == "compose" ]]; then
  echo "Using docker compose..."
  docker-compose -f docker-compose.yaml -p galera up -d

elif [[ "$mode" == "swarm" ]]; then
  echo "Using docker swarm..."
  export $(cat .env) > /dev/null 2>&1;
  echo ""
  echo -e "Stack Name\t= ${1:-$STACK_NAME}";
  echo -e "Image Version \t= $VERSION"
  echo -e "MANAGER1 \t= $MANAGER1"
  echo -e "MANAGER2 \t= $MANAGER2"
  echo -e "MANAGER3 \t= $MANAGER3"
  echo -e "WORKER1 \t= $WORKER1"
  echo -e "WORKER2 \t= $WORKER2"
  echo ""

  docker stack deploy -c stack.yml ${STACK_NAME}
fi
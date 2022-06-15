#!/bin/bash

docker-compose -f docker-compose.yaml up -d
echo ""
sleep 5


if [[ -f ./.env ]]; then
  echo "Using environment: .env"
  source .env
else
  echo "Environment file '.env' not exist!"
  echo "Using environment: '.env.sample'"
fi
waiting="True"
running="False"
initialize="False"
until [ "$waiting" == "False" ]; do
ERROR_MSG=$(docker exec -u postgres -it psql-1 psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:5432/${DB_NAME} -l 1> /dev/null)

# #
# # Check the output. If it is not empty then everything is fine and we return
# # something. Else, we just do not return anything.
# #
if [ "$ERROR_MSG" == "" ]
then
  docker exec -u postgres -it psql-1 psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:5432/${DB_NAME} -l | grep "List of databases" &> /dev/null
  list_db=$(echo "$?")
  if [ ${list_db} -eq 0 ]; then
    running="True"
    waiting="False"
  fi
  docker exec -u postgres -it psql-1 psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:5432/${DB_NAME} -l
else
  # psql is not ready
  waiting="True"
  running="False"
fi
sleep 3
done

unset $(cat .env | cut -d'=' -f1)
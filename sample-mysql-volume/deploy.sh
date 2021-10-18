#!/bin/bash

mkdir ./dbdata
docker-compose -f docker-compose.yaml up -d

echo ""
sleep 5

source .env
waiting="True"
running="False"
initialize="False"
until [ "$waiting" == "False" ]; do
ERROR_MSG=`docker exec -it db1 /usr/bin/mysql --user=admin --password=$DB_PASSWORD -e "show databases;" 2>/dev/null`

#
# Check the output. If it is not empty then everything is fine and we return
# something. Else, we just do not return anything.
#
if [ "$ERROR_MSG" != "" ]
then
  # mysql is fine, return http 200
  if [ "$running" == "False" ]; then
    echo -n "HTTP/1.1 200 OK; "
    echo "MySQL is running; "
    running="True"
  fi
  # echo -e "result: \n$ERROR_MSG"
  if [[ $ERROR_MSG == *"ERROR "* ]]; then
    if [ "$initialize" == "False" ]; then
      echo -n "Initialize database.."
      initialize="True"
    fi
    echo -n "."
    waiting="True"
  else
    echo -e "\nInitialize complete!"
    waiting="False"
    running="True"
    initialize="False"
    docker exec -it db1 /usr/bin/mysql --user=admin --password=$DB_PASSWORD -D sample_db -e "show tables;"
  fi
else
  # mysql is fine, return http 503
  echo "HTTP/1.1 503 Service Unavailable"
  echo "MySQL is *down*."
  waiting="True"
  running="False"
  initialize="False"
fi
sleep 3
done

unset $(cat .env | cut -d'=' -f1)
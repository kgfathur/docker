#!/bin/bash

export $(cat .env) > /dev/null 2>&1;
echo -e "Stack Name\t= ${1:-$STACK_NAME}";
echo ""
docker stack rm ${1:-$STACK_NAME}
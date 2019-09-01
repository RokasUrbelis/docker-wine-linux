#!/bin/bash
docker start docker-wine
docker exec -i docker-wine /usr/bin/nohup /bin/bash &>/dev/null $1 &

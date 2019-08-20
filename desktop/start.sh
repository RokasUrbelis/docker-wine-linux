#!/bin/bash
BASE_PATH=$(cd `dirname $0`; pwd)
killall xdg-open-server
$BASE_PATH/../contrib/xdg-open-server/xdg-open-server&
docker start docker-wine
docker exec -i docker-wine /usr/bin/nohup /bin/bash &>/dev/null $1 &

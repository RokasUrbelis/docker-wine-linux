#!/bin/bash
xhost + &>/dev/null

echo -n "[\033[32m\033[5m+\033[0m]Cloning speed may be slow, please waitting..."

git clone https://github.com/wszqkzqk/deepin-wine-ubuntu.git

##########build docker image
sudo docker build -t docker-wine-linux ./ && sed -i '2,7s/^/#&/g;9,13s/^/#&/g' $0

#########create docker container
mkdir -p $(pwd)/APP_PATH && sudo docker run -d -ti -v $(pwd)/APP_PATH:/root -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY  -e GDK_SCALE -e GDK_DPI_SCALE \
	--name docker-wine-$RANDOM docker-wine-linux /bin/bash|awk '{print substr($0,1,3)}'|tee docker.id &>/dev/null

dockerid=$(cat docker.id)

awk 'BEGIN{printf "Your container id is ";system("cat docker.id && echo");system("echo -n [\033[32m\033[5m+\033[0m]");printf "Run [source start.sh -i '" $dockerid "'";printf "TIM] to run TIM or another APP\n"}'
echo && echo "Exec 'bash start.sh --help' for more information."
shred -f -u -v -z docker.id >/dev/null 2>&1

#!/bin/bash
if sudo apt-get install x11-xserver-utils -y;then
	:
else
	echo "I can't install x11-xserver-utils,please manual install it!"
	exit 1
fi
xhost + &>/dev/null
git clone https://github.com/wszqkzqk/deepin-wine-ubuntu.git
##########build docker image
sudo docker build -t docker-wine-linux ./ && sed -i '2,7s/^/#&/g;9,11s/^/#&/g' $0
sudo docker run -d -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY  -e GDK_SCALE -e GDK_DPI_SCALE \
	--name docker-wine-$RANDOM docker-wine-linux /bin/bash|awk '{print substr($0,1,3)}'|tee docker.id &>/dev/null

dockerid=$(cat docker.id)
awk 'BEGIN{printf "Your container id is ";system("cat docker.id");printf "\nRun [source start.sh -i '" $dockerid "'";printf "TIM] to run TIM or another APP\n"}'
shred -f -u -v -z docker.id >/dev/null 2>&1

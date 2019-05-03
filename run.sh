#!/bin/bash
xhost + &>/dev/null
set -e
echo -e "[\033[32m\033[5m+\033[0m]Please wait for cloning... It might take a while."
DIR="deepin-wine-ubuntu"
[ -d $DIR ] && rm -rf $DIR 
git clone https://github.com/wszqkzqk/${DIR}.git

# Build docker image
if sudo docker build -t docker-wine-linux ./; then
	sed -i '4,14s/^/#&/g' $0
else
	echo "Failed to build Docker Image. Exiting..."
	exit 127
fi
# Create docker container
function CREATE() {
mkdir -p $(pwd)/APP_PATH
if sudo docker run -d -ti -v $(pwd)/APP_PATH:/root -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY  -e GDK_SCALE -e GDK_DPI_SCALE \
 --name docker-wine-$RANDOM docker-wine-linux /bin/bash|awk '{print substr($0,1,3)}'|tee docker.id &>/dev/null; then
	dockerid=$(cat docker.id)
	return 0
else
	echo "Failed to create container. Exiting..."
	return 127
fi
}
CREATE

code=$?
if [ "$code" == "0" ]; then
	awk 'BEGIN{printf "Your Container ID is ";system("cat docker.id && echo");system("echo -n [\033[32m\033[5m+\033[0m]");\
	printf "Run [source start.sh -i '" $dockerid "'";printf "TIM] to run TIM or another APP\n"}'
	echo
	echo "Try 'bash start.sh --help' for more information."
	shred -f -u -v -z docker.id >/dev/null 2>&1
else
	exit 127
fi

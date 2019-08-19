#!/bin/bash
xhost + &>/dev/null
set -e
source "/etc/X11/xinit/xinputrc"
if docker build -t docker-wine-linux \
	--build-arg IM=$XIM \
	--build-arg USER_NAME=$USER \
	--build-arg UID=$(id -u) \
	--build-arg GID=$(id -g) \
	--build-arg AUDIO_GID=$(getent group audio | cut -d: -f3) \
	--build-arg VIDEO_GID=$(getent group video | cut -d: -f3) \
	./docker; then
	printf "build docker success\n"
else
	printf "build docker image error,exit process\n"
	exit 127
fi
#########create docker container
function CREATE() {
	mkdir -p $(pwd)/APP_PATH
	docker rm -f docker-wine || true
	if docker run -d -ti -v $(pwd)/APP_PATH:/home/$USER \
		--device /dev/snd --group-add audio \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY  -e GDK_SCALE -e GDK_DPI_SCALE \
		-v $(pwd)/docker/fonts:/usr/share/fonts/wine:ro \
		--ipc=host \
	 	--name docker-wine --user $USER:$(id -u) docker-wine-linux /bin/bash|awk '{print substr($0,1,3)}'|tee docker.id &>/dev/null; then
			docker exec -i docker-wine bash -c "find /opt/deepinwine/apps/ -name *.sh | xargs -i sh {} -c \
				&& FONTS=\$(find /home/$USER/.deepinwine/*/drive_c/windows/ -maxdepth 0 -type d -name Fonts) \
				&& for FONT in \$FONTS; do find /usr/share/fonts/wine/ -type f | xargs -i ln -s {} \$FONT; done \
				&& find /home/$USER/.deepinwine/Deepin-* -type d -maxdepth 0 | xargs -i@ env WINEPREFIX=@ deepin-wine reg add 'HKEY_CURRENT_USER\Control Panel\Desktop' /v LogPixels /t REG_DWORD /d 0x78 /f \
				&& find /home/$USER/.deepinwine/Deepin-* -type d -maxdepth 0 | xargs -i@ env WINEPREFIX=@ deepin-wine reg add 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Hardware Profiles\Current\Software\Fonts' /v LogPixels /t REG_DWORD /d 0x78 /f \
				"
			dockerid=$(cat docker.id)
		return 0
	else
		printf "create container error,exit process\n"
		return 127
	fi
}
CREATE
code=$?
if [ "$code" == "0" ]; then
	awk 'BEGIN{printf "Your container id is ";system("cat docker.id && echo");system("echo -n [\033[32m\033[5m+\033[0m]");\
	printf "Run [source start.sh -i '" $dockerid "'";printf "TIM] to run TIM or another APP\n"}'
	echo
	echo "Exec 'bash start.sh --help' for more information."
	shred -f -u -v -z docker.id >/dev/null 2>&1
else
	exit 127
fi

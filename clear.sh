#!/bin/bash
# Empty the docker container.
# We recommend to clean it at least once a month, this tool can be combined with
# crontab, which means you don't need to do it manually.
# This script also will empty APP_PATH subfile, you can backup it before cleaning if you want.
CLEAR_CONTAINER() {
		for i in $(awk '/docker-wine-linux/{print $1}'< <(sudo docker ps -a))
		do
		       	sudo docker stop $i && sudo docker rm $i
		done

}
read -p "Are you sure of cleaning the docker container of docker-wine-linux [y/N]? "
case ${REPLY} in 
	'Y'|'y')
		CLEAR_CONTAINER && echo 'Done.' && exit 0
		;;
	*)
		exit 0
		;;
esac

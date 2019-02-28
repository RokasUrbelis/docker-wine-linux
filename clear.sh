#!/bin/bash
###clear docker container,recommended to execute at least once a month, which can be combined with crontab.
###the script will clear APP_PATH subfile,if you want,you can back it before clear
function CLEAR_CONTAINER() {
		for i in $(awk '/docker-wine-linux/{print $1}'< <(sudo docker ps -a))
		do
		       	sudo docker stop $i && sudo docker rm $i
		done

}
while true;do
	read -p 'Are you sure clear the docker container for docker-wine-linux?[Y/N]'
	case ${REPLY} in 
		'Y'|'y')
			CLEAR_CONTAINER && echo 'clear done' && exit 0
			;;
		'N'|'n')
			exit 0
			;;
		      *)
			echo -e 'Sorry,input error,please input again\n' && continue
			;;
	esac
done

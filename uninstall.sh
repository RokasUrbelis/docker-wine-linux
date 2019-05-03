#!/bin/bash
UNINSTALL() {
	for i in $(awk '/docker-wine-linux/{print $1}'< <(sudo docker ps -a))
	do
	       	sudo docker stop $i && sudo docker rm $i
	done
	# Stop Docker Container
	for i in $(sudo docker images> >(awk '$1~/docker-wine-linux/{print $3}'))
	do 
		sudo docker rmi $i
	done
	# Remove docker image
	echo "Uninstalled."
}

while :;do
	read -p "Are you sure of uninstalling this project? [y/N]:
	case ${REPLY} in
		'Y'|'y')
			      UNINSTALL && exit 0
			      ;;
	        *)
			      exit 0
			      ;;
	esac
done

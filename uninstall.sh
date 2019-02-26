#!/bin/bash
function UNINSTALL() {
	for i in $(awk '/docker-wine-linux/{print $1}'< <(sudo docker ps -a))
	do
	       	sudo docker stop $i && sudo docker rm $i
	done
	###stop docker container
	for i in $(sudo docker images> >(awk '$1~/docker-wine-linux/{print $3}')
)
	do 
		sudo docker rmi $i
	done
	###remove docker image
	echo "Unstall done"
}

while :;do
	read -p "Are you sure uninstalli the project?[Y/N]:"
	case ${REPLY} in
		'Y'|'y')
			      UNINSTALL && exit 0
			      ;;
		'N'|'n')
			      exit 0
			      ;;
	        *)
		        echo 'Input error,please input again!'
			      continue
			      ;;
	esac
done

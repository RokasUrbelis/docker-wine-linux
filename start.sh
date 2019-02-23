#!/bin/bash
function RUN_APP() {
	sudo docker exec -ti $1 /usr/bin/nohup /bin/bash &>/dev/null $2 &
 }
case ${1} in
	-i)
		RUN_APP $2 $3
		;;
	 *)
		echo 'Usage:'
		echo '		-i  [Docker container id or name] [APP Name]'
		echo '		APP Nmae list:'
		echo '          	      QQ'
		echo ' 			      TIM'
		echo ' 			      WeChat'
		echo ' 			      BaiduNetDisk'
		echo '			      ThunderSpeed'
		echo 'Example: source start.sh -i 0af TIM'

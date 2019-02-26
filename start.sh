#!/bin/bash
function RUN_APP() {
	sudo docker exec -ti $1 /usr/bin/nohup /bin/bash &>/dev/null $2 &
 }
function USAGE() {

		echo 'Usage:'
		echo '		-i  [Docker container id or name] [APP Name]'
		echo '		APP Nmae list:'
		echo '          	      QQ'
		echo ' 			      TIM'
		echo ' 			      WeChat'
		echo ' 			      BaiduNetDisk'
		echo '			      ThunderSpeed'
		echo 'Example: source start.sh -i 0af TIM'
}
APP_LIST=(
QQ
TIM
WeChat
BaiduNetDisk
ThunderSpeed
Foxmail
)
if [ $# != 3 ];then
	USAGE
else 
	case ${1} in
		-i)
			shift ##ID
			if { cat demo.txt|& grep $1; } &>/dev/null;then
				ID=$1
				shift ##APP
			        { for i in ${APP_LIST[@]};do echo $i;done |& grep -i "^${1}$"; } &>/dev/null　&&　RUN_APP ${ID} $2 \
				|| echo "Sorry,'$1' not in list"
			else
				echo "Sorry,not found docker container id '$1'"
			fi
			;;
	 	*)
			USAGE
			;;
	esac
fi

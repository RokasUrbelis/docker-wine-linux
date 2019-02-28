#!/bin/bash
function RUN_APP() {
	sudo docker exec -ti $1 /usr/bin/nohup /bin/bash &>/dev/null $2 &
 }
function USAGE() {

		echo 'Usage:'
		echo '		-i  [Docker container id or name] [APP Name]'
		echo '		APP Nmae list:'
		echo ' 			      QQ'
		echo ' 			      TIM'
		echo ' 			      WeChat'
		echo ' 			      BaiduNetDisk'
		echo '			      ThunderSpeed'
		echo '			      Foxmail'
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
			if { sudo docker ps -a |& grep $1; } &>/dev/null;then
				ID=$1
				shift ##APP
				{ for i in ${APP_LIST[@]};do echo $i;done |& grep -i "^${1}$"; } 2>/dev/null 1>APP &&  RUN_APP ${ID} $(cat APP) \
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
[ -f APP ] && shred -f -u -z APP >/dev/null 2>&1

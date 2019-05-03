#!/usr/bin/bash
RUN_APP() {
	sudo docker exec -ti $1 /usr/bin/nohup /bin/bash &>/dev/null $2 &
}

USAGE() {

		echo 'Usage:'
		echo '		-i  [Docker Container ID or name] [APP_NAME]'
		echo '		<APP_NAME> list:'
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

if [ $# != 3 ]
then
	USAGE
else 
	case ${1} in
		-i)
			shift # ID
			if { sudo docker ps -a |& grep $1; } &>/dev/null;then
				ID=$1
				shift # APP
				{ for i in ${APP_LIST[@]};do echo $i;done |& grep -i "^${1}$"; } 2>/dev/null 1>APP &&  RUN_APP ${ID} $(cat APP) \
				|| echo "ERROR: \"$1\" isn't in this list."> /dev/stderr
			else
				echo "ERROR: Docker Container ID \"$1\" doesn't exist."
			fi
			;;
	 	*)
			USAGE
			;;
	esac
fi
[ -f APP ] && shred -f -u -z APP >/dev/null 2>&1

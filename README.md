# docker-wine-linux
[![](https://img.shields.io/badge/wine-2.08-red.svg)](https://winehq.org)
[![](https://img.shields.io/badge/docker-18.09-blue.svg)](https://www.docker.com)
[![](https://img.shields.io/badge/Ubuntu-18.04-orange.svg)](https://www.ubuntu.com)
![](https://img.shields.io/github/stars/RokasUrbelis/docker-wine-ubuntu.svg?label=Stars&style=social)
## 获取并安装
::fire::
```shell
# Clone this repository
git clone https://github.com/RokasUrbelis/docker-wine-linux.git

# Go into the repository
cd docker-wine-linux

# Build docker image and run docker container for first time
bash run.sh
``` 
>因为需要构建docker镜像和克隆deepin-wine-ubuntu，第一次执行run.sh的时间较长，此时你去外面遛弯都是没问题的


***如果你的系统未安装docker，请先执行以下命令安装docker:***
```shell
curl -fsSL https://get.docker.com|bash
### 如果你的系统使用此命令依旧安装不了，请移步至docker官网查看安装文档。
```
****由于docker需要系统要求内核版本至少高于`2.6.32`上，如果内核未达标，请自行编译内核，可参考[此链接](https://blog.linux-code.com/articles/thread-1006.html)****
## 运行

```shell
# Create docker container
bash run.sh
```
#### 执行run.sh后会自动创建容器并后台运行，并且会告诉你容器id以及给出相应的命令让你执行,你可以执行它给出的命令来运行应用（默认是运行TIM)，执行格式为:
```shell
# Run application
source start.sh -i 容器id 应用名
##执行完此命令可能需要等待5-15秒钟，取决于系统响应速度
```
>因为wine有时候不稳定，运行完应用后发现登录上去看不到页面或者鼠标无法点击或者出现崩溃的情况都是正常的，因为第一次见到主人，wine很害羞(多运行一两次就正常了)，此时你需要kill掉后台pid或者删除容器，推荐每个wine应用使用单独容器运行(即每次运行应用前先运行run.sh)，而不是集中在一个容器上，这样方便管理并且降低崩溃概率。


#### 支持的应用有
- QQ
- TIM
- Wechat
- 百度网盘
- 迅雷急速版

#### 以下是在Debian上的运行截图(其他发行版也都是支持的):
##### (百度网盘&TIM)
![百度网盘&TIM](https://raw.githubusercontent.com/RokasUrbelis/docker-wine-ubuntu/master/screen/screen01.png)
##### (迅雷&WeChat)
![迅雷&WeChat](https://raw.githubusercontent.com/RokasUrbelis/docker-wine-ubuntu/master/screen/screen02.png)
##### (3D视图)
![3D视图](https://raw.githubusercontent.com/RokasUrbelis/docker-wine-ubuntu/master/screen/screen03.png)
#### 此项目使用[deepin-wine-ubuntu](https://github.com/wszqkzqk/deepin-wine-ubuntu)作为运行环境，ubuntu:latest作为docker容器，构建了一套容器上运行应用，并把图形化输出到宿主机的DISPLAY控制器的docker容器，支持多个发行版。


# docker-wine-ubuntu

## 获取并安装
```shell
git clone https://github.com/RokasUrbelis/docker-wine-ubuntu.git
bash run.sh
``` 
>第一次执行run.sh的时间较长，此时你去外面遛弯都是没问题的


***如果你的系统未安装docker，请先执行以下命令安装docker:***
```shell
curl -fsSL https://get.docker.io|bash
```
## 运行

```shell
bash run.sh
```
#### 执行run.sh后会自动创建容器并后台运行，并且会告诉你容器id以及给出相应的命令让你执行,你可以执行它给出的命令来运行应用（默认是运行TIM)，执行格式为:
```shell
source start.sh -i 容器id 应用名
```
>因为wine有时候不稳定，运行完应用后发现登录上去看不到页面或者出现崩溃的情况都是正常的，因为第一次见到主人，wine很害羞，多运行一两次就正常了。


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


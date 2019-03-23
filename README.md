
<img src="https://github.com/RokasUrbelis/docker-wine-linux/blob/master/screen/asset/wine.png" alt="logo" height="120" align="right" />


# Docker wine for all linux distros

[![](https://img.shields.io/badge/Linux-All_DISTROS-green.svg)](https://www.gnu.org)
[![](https://img.shields.io/badge/Deepin_Wine-2.18|BASCI_ENVIRONMENT-red.svg)](https://winehq.org)
[![](https://img.shields.io/badge/Docker-18.09-blue.svg)](https://www.docker.com)
[![](https://img.shields.io/badge/Ubuntu-Latest|DOCKER_IMAGE-orange.svg)](https://www.ubuntu.com)
![](https://img.shields.io/github/stars/RokasUrbelis/docker-wine-linux.svg?label=Stars&style=social)

![First_image](https://github.com/RokasUrbelis/docker-wine-linux/blob/master/screen/screen00.png)



# 一、项目介绍
>Deepin-wine环境的全Linux发行版的移植版（支持所有Linux发行版）

>使用deepin原版二进制文件，解决依赖问题

>使用docker作为运行容器，方便管理、删除、卸载、打包、迁移等

>仅供个人研究学习使用，希望它对你有所帮助，你也可以 fork 或者转载（标注来源）

## :label:运行必要条件
- 操作系统:Linux
- 应用软件:Docker

***如果你的系统未安装docker，请先执行以下命令安装docker:***
```shell
curl -fsSL https://get.docker.com|bash
# 如果使用此命令依旧安装不了，请移步至docker官网查看安装文档。
```
#### 由于docker需要系统要求内核版本至少高于`2.6.32`上，如果内核未达标，请自行编译内核，可参考[此链接](https://blog.linux-code.com/articles/thread-1006.html)

# 二、获取
```shell
# Clone this repository
git clone https://github.com/RokasUrbelis/docker-wine-linux.git

# Go into the repository
cd docker-wine-linux
``` 


# 三、运行及使用说明

#### (1):memo:目前只测试了`QQ/TIM/百度网盘/迅雷极速版/Foxmail`几个应用，如果你想自定义安装你需要的软件，可以到[阿里云镜像下载](http://mirrors.aliyun.com/deepin/pool/non-free/d/)对应deb包，`mv`到`deb`目录，之后再执行`bash run.sh`。
> 提醒一句，因为那些包是针对deepin开发的，用在Ubuntu镜像，使用过程中出现的任何意外情况都是正常的，不保证全部可以正常使用，除非确实有用的需求，否则不建议使用。我测试的这几个应用是毫无问题的。

#### 如果没有需求请直接执行:
```shell
bash run.sh
```
>因为需要构建docker镜像和克隆deepin-wine-ubuntu，第一次执行run.sh的时间较长(大概需要２－５分钟，取决于带宽及硬件配置)

#### (2):zap:执行run.sh后会自动创建容器并后台运行，并且会告诉你容器id以及给出相应的命令让你执行,你可以执行它给出的命令来运行应用（默认是运行TIM)，执行格式为:
```shell
source start.sh -i 容器id 应用名
#执行完此命令可能需要等待10-30秒钟，取决于系统响应速度
```
>应用名列表可执行`bash start.sh --help`查看帮助，应用名不区分大小写亦可运行

#### (3):bulb:重要提示:
- 因为wine有时候不稳定，运行完应用后发现登录上去看不到页面或者鼠标无法点击或者出现崩溃的情况都是正常的，因为第一次见到主人，wine很害羞(多运行一两次就正常了)，此时你需要kill掉后台pid或者删除容器来释放系统资源或者直接重新运行`run.sh`。
- 追求稳定的话建议每个wine应用使用单独容器运行(即每次运行应用前先运行run.sh)，而不是集中在一个容器上，这样方便管理并且降低崩溃概率。
>>亲测使用一个容器来运行所有应用也很少出现崩溃的情况，并且系统资源占用也相对前者少(如果不是强迫症，推荐此种方式运行wine应用)

# 四、常见问题
#### (1):card_file_box:应用使用过程文件传输的路径问题
- 执行完`run.sh`后会生成一个`APP_PATH`目录(以下简称此目录)，此目录已经映射到了你当前容器的`/root`目录，用户上传/下载文件的作用域都在此目录的子目录
- 只有登录应用才会在此目录生成对应应用的用户文件夹，你可以把你要上传的文件拷贝进去然后上传到应用
- 从应用中下载的重要文件最好从此目录拷贝到你的家目录或其他目录打开，因为容器处于非运行状态时用户是访问不了这些文件的，并且执行卸载操作的时候容器将全部被删除，此目录里的文件也会被销毁
- 多次运行容器或应用也不会影响文件存放路径，此目录是所有应用共用的空间，所以不必担心文件路径冲突等问题
#### (2):recycle:资源释放问题(通过删除容器的方式)
- 每执行一次`run.sh`会生成一个容器，每次重启系统这些容器就会处于退出状态，并且你不会再使用它，久而久之容器数量就会占据硬盘大量空间，直接执行`bash clear.sh`即可释放资源
- 建议至少每个月执行一次(每天执行一次更好)，具体多久执行一次取决于你系统资源是否够用以及开的容器数目是否够多，可配合crontab使用
- 执行`clear.sh`的时候所有与`docker-wine-linux`镜像有关的容器都将被删除，在此之前请备份好`APP_PATH`目录里面你通过应用传输的重要文件

# 五、支持的应用
#### :trophy:目前支持的应用有(持续更新):
- [x] QQ
- [x] TIM
- [x] Wechat
- [x] 百度网盘
- [x] 迅雷急速版
- [x] Foxmail

# 六、卸载方法
- 执行`bash uninstall.sh`即可

# 七、鸣谢
#### :lock:项目主要参考[deepin-wine-ubuntu](https://github.com/wszqkzqk/deepin-wine-ubuntu)(此项目主要是针对Ubuntu开发)，我只是通过容器与宿主机结合让它能在所有发行版中使用。如果我看的更远一点的话，是因为我站在巨人的肩膀上。
  
# 八、参与贡献
- Star/Fork本项目
- 新建 Feat_xxx 分支
- 提交代码
- 新建 Pull Request
      
# 九、运行截图 
#### :camera_flash:以下是在Debian上的运行截图(其他发行版也都是支持的):
##### (百度网盘&TIM)
![百度网盘&TIM](https://github.com/Acoustroal/docker-wine-linux/blob/master/screen/screen01.png)
##### (迅雷&WeChat)
![迅雷&WeChat](https://github.com/Acoustroal/docker-wine-linux/blob/master/screen/screen02.png)
##### (3D视图)
![3D视图](https://github.com/Acoustroal/docker-wine-linux/blob/master/screen/screen03.png)
#### :pencil2:此项目使用[deepin-wine-ubuntu](https://github.com/wszqkzqk/deepin-wine-ubuntu)作为基础环境，ubuntu:latest作为docker容器，构建了一套容器上运行应用，并把图形化输出到宿主机的DISPLAY控制器的docker容器，支持所有发行版。


#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM ubuntu:latest
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)


ARG IM=fcitx
ARG USER_NAME=Jason
ARG UID=1000
ARG GID=1000
ARG AUDIO_GID=63
ARG VIDEO_GID=39

COPY link.sh /root/
COPY deb/ /root/deb/
COPY sources.list /etc/apt/

RUN groupadd -o -f -g $GID $USER_NAME \
    && groupmod -o -g $AUDIO_GID audio \
    && groupmod -o -g $VIDEO_GID video \
    && useradd --system --uid=$UID --gid=$GID --home /home/$USER_NAME --shell /bin/bash $USER_NAME -G audio,video

RUN cd /root \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install wget git locales ttf-wqy-zenhei sudo tzdata xdotool -y \
    && apt-get clean \
    && apt-get autoclean \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 zh_CN.GBK \
    && update-locale LANG=zh_CN.UTF-8 \
    && git clone --depth 1 https://github.com/wszqkzqk/deepin-wine-ubuntu.git \
    && mv -f deb/* /root/deepin-wine-ubuntu/ \
    && rm -rf deb \
    && yes|bash /root/deepin-wine-ubuntu/install.sh \
    && /bin/bash /root/link.sh \
    && rm -f /root/link.sh \
    && rm -rf /root/deepin-wine-ubuntu

ENV LC_CTYPE=zh_CN.UTF-8 \
    XIM=$IM \
    GTK_IM_MODULE=$IM \
    QT_IM_MODULE=$IM \
    XMODIFIERS="@im=$IM"

WORKDIR /home/$USER_NAME

CMD ["/bin/bash"]
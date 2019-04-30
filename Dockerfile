#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM ubuntu:latest
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)

ADD deepin-wine-ubuntu /root/deepin-wine-ubuntu
COPY link.sh /root/
COPY deb/ /root/deepin-wine-ubuntu/
#COPY sources.list /etc/apt/
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update

RUN apt-get install wget git locales ttf-wqy-zenhei sudo -y
RUN apt-get clean && apt-get autoclean
ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"

RUN \
  locale-gen en_US.UTF-8 zh_CN.UTF-8 \
  zh_CN.GBK && \
  update-locale LANG=zh_CN.UTF-8

# Define default command.

RUN yes|bash /root/deepin-wine-ubuntu/install.sh
#RUN cd && ln -s /opt/deepin-wine-ubuntu/app/* .
RUN /bin/bash /root/link.sh && rm -f /root/link.sh
RUN rm -rf /root/deepin-wine-ubuntu
WORKDIR /root

CMD ["/bin/bash"]

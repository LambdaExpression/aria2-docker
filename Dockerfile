FROM alpine:3.14.0

MAINTAINER lambdaexpression <lambdaexpression@163.com>

WORKDIR /root/Download

# 更改源
RUN echo -e 'http://mirrors.ustc.edu.cn/alpine/v3.14/main/\nhttps://mirrors.ustc.edu.cn/alpine/v3.14/community' > /etc/apk/repositories

RUN apk update 
RUN apk add --update apache2-utils openssl
RUN apk add nginx
RUN apk add nginx-mod-http-fancyindex
RUN apk add aria2

RUN rm -rf /var/cache/apk/*

WORKDIR /opt/aria2_config
ADD aria2_config /opt/aria2_config
ADD start.sh /opt

WORKDIR /root/Download

ENV login=n username= password=
VOLUME ["/root/Download", "/root/.aria2"]
EXPOSE 6800/tcp 6801/tcp 6802/tcp

RUN mkdir /opt/aria2_config/nginx && cp -rf /etc/nginx/* /opt/aria2_config/nginx

CMD /opt/start.sh;/bin/sh

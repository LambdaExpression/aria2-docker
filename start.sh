#!/bin/sh

if [ -d "/opt/aria2_config" ]; then
  cp -rf /opt/aria2_config/nginx/* /etc/nginx/
  /opt/aria2_config/config.sh;
  rm -rf /opt/aria2_config;
fi

nginx -c /etc/nginx/nginx.conf;
aria2c -D;

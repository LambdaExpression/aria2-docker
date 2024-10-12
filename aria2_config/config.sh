#!/bin/sh

ariaNg=AriaNg-1.3.7
#kiftd=kiftd-v1.0.35

# 随机生成 rpc 密钥
secret=$( openssl rand -hex 10 )
base64Secret=$( echo -n $secret | base64 )
mkdir -p /root/.aria2
mkdir -p /opt/AriaNg
rm -rf /opt/AriaNg/*
mv /root/.aria2/aria2.conf /root/.aria2/aria2.conf_bak || :
cp /opt/aria2_config/aria2.conf  /root/.aria2/aria2.conf
cp -rf /opt/aria2_config/$ariaNg/* /opt/AriaNg
sed -i "s/{secret}/$secret/g" /root/.aria2/aria2.conf
sed -i "s/secret:\"\"/secret:\"$base64Secret\"/g" `grep 'secret:""' -rl /opt/AriaNg/js`
echo "" > /root/.aria2/aria2.session

cp -f /opt/aria2_config/nginx.conf /etc/nginx/nginx.conf
if [ $login ] && [ $username ] && [ $password ] && [ "$username" != "" ] && [ "$password" != "" ];then
	if [ "$login" = "y" ] || [ "$login" = "Y" ] || [ "$login" = "yes" ] || [ "$login" = "Yes" ] || [ "$login" = "YES" ];then
	  rm -rf /etc/nginx/htpasswd
	  htpasswd -bc /etc/nginx/htpasswd $username $password
	  sed -i "s/#auth_basic/auth_basic/g" /etc/nginx/nginx.conf
	  sed -i "s/#auth_basic_user_file/auth_basic_user_file/g" /etc/nginx/nginx.conf
	fi
fi

if [ ! -d "/etc/nginx/fancyindex-theme/Nginx-Fancyindex-Theme" ]; then
  mkdir -p /etc/nginx/fancyindex-theme
  cp -rf /opt/aria2_config/Nginx-Fancyindex-Theme /etc/nginx/fancyindex-theme/Nginx-Fancyindex-Theme
fi

echo "aria2 rpc secret:$secret"

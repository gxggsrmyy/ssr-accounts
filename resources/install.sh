#!/bin/bash

## install dependencies
yum install -y vim gcc gcc-c++ wget unzip net-tools openssl-devel python jq qrencode bind-utils
#tar xzf rarlinux*; (cd rar; make)


## set links
page_path=/usr/local/nginx/html/info
mkdir -p $page_path
video_path=/usr/local/nginx/html/content/videos
mkdir -p $video_path

local_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)
sed "s/localhost/$local_ip/g" link.html > $page_path/ss.html
sed -i "s/type/ss/" $page_path/ss.html

sed "s/localhost/$local_ip/g" link.html > $page_path/ssr.html
sed -i "s/type/ssr/" $page_path/ssr.html

sed "s/localhost/$local_ip/g" videos.html > $video_path/index.html


## install ssr & bbr
unzip shadowsocksr.zip
cp -R shadowsocksr /usr/local/shadowsocksr
chmod +x ssr.sh && bash ssr.sh
chmod +x bbr.sh && bash bbr.sh


## enable ssr service
cp ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start

## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off



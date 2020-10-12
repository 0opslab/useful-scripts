#!/bin/bash

# @auth 0opslab
# @descript 此方法用于被动分析nginx日记找出请求数较大的IP，并用iptables封掉，如需主动限制
# @usgae 将以下脚本添加到 crontab中

num=100 #上限
cd /home/wwwlogs
for i in `tail access.log -n 1000|awk '{print $1}'|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'`
do
      iptables -I INPUT -p tcp -s $i --dport 80 -j DROP
done
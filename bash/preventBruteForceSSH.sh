#!/bin/bash
# @auth 0opslab
# @descript 此脚本用于分析统计secure日记文件，对ssh登录错误次数较多的IP用iptables封掉。
# @usgae 将以下脚本添加到 crontab中

num=10
for i in `awk '/Failed/{print $(NF-3)}' /var/log/secure|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'`
do
       iptables -I INPUT -p tcp -s $i --dport 22 -j DROP
done
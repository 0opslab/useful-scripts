#!/bin/bash


# 获取某一个网段内所有主机的mac地址
for i in `seq 254` 
do
	arping -c 2 192.168.0.$i|grep ^Unicast|awk '{print $4,$5}'
done

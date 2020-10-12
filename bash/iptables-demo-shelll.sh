#!/bin/sh

#######################################################
#       请勿执行,这里只是一些配置实例，仅供参考
#
#######################################################

#iptables基本语法#
    #基本语法类似如下形式:
    iptables -t filter -A INPUT -p icmp -j DROP

#0.设置filter的默认规则
iptables -t filter -P DROP

#1.将192.168.0.200进入本机的icmp丢弃
iptables -t filter -A INPUT -p icmp -s 192.168.0.200 -j DROP

#2.丢弃192.168.0.200通过本机信息DNS解析
iptables -t filter -A INPUT -p udp -s 192.168.0.200 --dport 53 -j DROP

#3.允许192.168.0.100链接本机的SSH服务
iptables -t filter -A INPUT -p tcp -s 192.168.0.100 --dport 22 -j ACCEPT

#4.只允许从eth0接口访问tcp/80端口
iptables -t filter -A INPUT -p tcp -i eth0 --dport 80 -j ACCEPT

#5.不允许通过本主机访问外部的任务网站
iptables -t filter -A INPUT -p tcp -o eth0 --dport 80 -j DROP


# INPUT chain
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## CCS
iptables -A INPUT -s 1.1.1.1 -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -s 1.1.1.1 -p icmp -m icmp --icmp-type 8 -j ACCEPT


#yewu
iptables -A INPUT -p tcp -m multiport --dports 1440,1450,8099,8085 -j ACCEPT


## SMOKEPING
iptables -A INPUT -s 1.1.1.1 -p icmp -j ACCEPT

## Zabbix
iptables -A INPUT -s 1.1.1.1 -p tcp -m tcp --dport 10050 -j ACCEPT
iptables -A INPUT -s 1.1.1.1 -p icmp -m icmp --icmp-type 8 -j ACCEPT

## Log Backup Server
iptables -A INPUT -s 1.1.1.1 -p tcp -m tcp --dport 19666 -j ACCEPT

## JiaGu
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT

## Default INPUT
iptables -P INPUT DROP


# OUTPUT chain
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

## Statistical system transmission
iptables -A OUTPUT -d 1.1.1.1 -p tcp --dport 20001 -j ACCEPT

## syscenter
iptables -A OUTPUT -d 1.1.1.1 -p tcp --dport 8090 -j ACCEPT

## Log Backup
iptables -A OUTPUT -d 1.1.1.1 -j ACCEPT

## SYSLOG
iptables -A OUTPUT -d 1.1.1.1 -p udp -m udp --dport 514 -j ACCEPT

## Time Sync
iptables -A OUTPUT -d 1.1.1.1 -p udp -m udp --dport 123 -j ACCEPT

## Puppet
iptables -A OUTPUT -d 1.1.1.1 -p tcp --dport 55120 -j ACCEPT
iptables -A OUTPUT -d 1.1.1.1 -p tcp --dport 8140  -j ACCEPT

## DNS
iptables -A OUTPUT -p udp  -m udp  --dport 53    -j ACCEPT
iptables -A OUTPUT -p tcp  -m tcp  --dport 53    -j ACCEPT
iptables -A OUTPUT -p tcp  -m tcp  --dport 123   -j ACCEPT
iptables -A OUTPUT -p tcp  -m tcp  --dport 2258  -j ACCEPT
iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

## Mysql
iptables -A OUTPUT -p tcp  -m tcp  --dport 3306 -j ACCEPT

## Vesta
iptables -A OUTPUT -p tcp -m multiport --dports 8081,9094,9095,9096,9097 -j ACCEPT

## Yum
iptables -A OUTPUT -p tcp -m tcp --dport 88 -j ACCEPT

## Zabbix
iptables -A OUTPUT -p tcp -m multiport --dports 10050,10051 -j ACCEPT

## SALT
iptables -A OUTPUT -p tcp -m multiport --dports 4505,4506 -j ACCEPT

## Billing 
iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT

## JiaGu
iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT

## SRCYNC
#iptables -A OUTPUT -p tcp -m tcp --dport 873 -j ACCEPT

## Default OUTPUT
iptables -P OUTPUT DROP


# FORWARD chain
iptables -P FORWARD DROP

/etc/init.d/iptables save

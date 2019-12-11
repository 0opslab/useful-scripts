#!/bin/bash
# Name:auto_banned_ip_on_centos7.sh
# Author:Lauer Smith
# Description:auto banned ip by firewalld

bannedIP() {
    reload=false
    firewall_list=`firewall-cmd --list-rich-rules`
    while read line; do
        total_num=`echo $line|cut -d ' ' -f 1`
        if [ $total_num -gt 10 ]; then
            ip=`echo $line|cut -d ' ' -f 2`
            already=`echo $firewall_list|grep "$ip"`
            if [ "$already" = "" ]; then
                now=`date "+%F %T"`
                echo "$now $ip" >> /var/log/auto_banned_ip.log
                reload=true
                firewall-cmd --permanent --zone=public --add-rich-rule="rule family=ipv4 source address=$ip reject"
                #echo firewall-cmd --permanent --zone=public --add-rich-rule="rule family=ipv4 source address=$ip reject"
            fi
        fi
    done
    if [ "$reload" = "true" ]; then
        firewall-cmd --reload
    fi
}
cat /var/log/secure|grep "Failed password"|awk -F"from " '{print $2}'|awk '{print $1}'|sort|uniq -c|sort -n|bannedIP

#!/bin/sh
source ~/.bash_profile
name=tomcat_wap
fullpath=/webapp/$name
count=`ps -eLf|grep ${name} | grep -v grep |wc -l`
rm -rf /webapp/tomcat_wap/tomcat9182/work/Catalina/localhost/*
rm -rf /webapp/tomcat_wap/tomcat9282/work/Catalina/localhost/*
rm -rf /webapp/tomcat_wap/tomcat9382/work/Catalina/localhost/*
rm -rf /webapp/tomcat_wap/tomcat9482/work/Catalina/localhost/*
echo $count
if [ ${count} = 0 ];then
   echo "${name} Servers  has shutdown!"
else
   ps -ef |grep $name|grep -v grep|awk '{print($2)}'|xargs kill -9
   echo "${name} Servers is stop  now!"
fi

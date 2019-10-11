#!/bin/sh

# author:0opslab
# restart

tomcat_path=/usr/local/tomcat_wap/

cd $fullpath
for i in  `ls  $fullpath`
do
        if [ -d $i ];then
        	echo " stop ${name}/${i} Server"
                ps -ef | grep ${tomcat_path}/$i | awk '{print $2}' | xargs kill -9
                rm -rdf ${tomcat_path}/$i/temp/*
                rm -rdf ${tomcat_path}/$i/work/*
                echo " clean ${tomcat_path}/$i temp"
                $fullpath/$i/bin/startup.sh > /dev/null &
                echo "${name} Server ${i} just start!"
        fi
done

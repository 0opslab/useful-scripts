#!/bin/bash

# author:0opslab
# 重新更新代码并部署到mysql下

# 重启进程
funRestartTSApp(){
    # 重启进程
    ProcNumber=`ps -ef |grep 'tianshu-app'| grep -v grep | awk '{print $2}'`
    echo $ProcNumber
    if [ "$ProcNumber" == "" ];then
        echo "The process does not exist and is started"
        nohup java -jar /local/workspace/build/tianshu-app-1.0.0.jar --spring.profiles.active=pro >> /data/log/tianshu-run.log  2>&1 &
    else
        echo "The process will restart"
        kill -9 $ProcNumber
        nohup java -jar /local/workspace/build/tianshu-app-1.0.0.jar --spring.profiles.active=pro >> /data/log/tianshu-run.log  2>&1 &
    fi
}

## 备份代码
datestr=`date +%Y%m%d%H%M%S`
mkdir /local/workspace/back/${datestr}
find /local/workspace/build/ -name "*.jar" -exec mv "{}" /local/workspace/back/${datestr} \;

## 更新svn代码并重新打包
cd /local/workspace/tianshu/
/usr/bin/svn update . && mvn clean && mvn package \
  && find /local/workspace/tianshu/ -name *.jar -exec  cp {} /local/workspace/build/ \; \
  && funRestartTSApp
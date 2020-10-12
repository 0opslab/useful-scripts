#!/bin/bash
###
 # @Author: your name
 # @Date: 2020-09-24 16:40:33
 # @LastEditTime: 2020-09-24 16:43:46
 # @LastEditors: Please set LastEditors
 # @Description: 将以下内容写入到~/.bashrc文件中 就可以行命令一样执行
 # @FilePath: \staticc:\workspace\useful-scripts\bash\xcall-functions.sh
### 



xcall(){
    list=('135.191.107.124' '135.191.107.125' '135.191.107.126')

    for host in ${list[@]}
    do
        echo ====================$host======================
        ssh $host $1
    done    
} 



ecplog(){
    txt=$1
    cmd="find /webapp02/logs/ -name \"crmDetail_*.log\" -exec grep --color \"${txt}\" {} \;"
    list=('135.191.107.124' '135.191.107.125' '135.191.107.126')

    for host in ${list[@]}
    do
        echo ====================$host======================
        #echo == $cmd
        ssh $host $cmd
    done
}


ecpdatelog(){
    txt=$1
    cmd="find /webapp02/logs/ -name \"crmDetail_*$1\" -exec grep --color \"$2\" {} \;"
    list=('135.191.107.124' '135.191.107.125' '135.191.107.126')

    for host in ${list[@]}
    do
        echo ====================$host======================
        ssh $host $cmd
    done  
}
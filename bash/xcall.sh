#!/bin/bash
#验证参数
#配合免密使用
if(($#==0))
then
    echo 请输入要执行的命令!
    exit;
fi
echo "正在执行的命令是:$@"
#2. 遍历所有目录，挨个发送
for host in mac1 mac2 mac3
do  
    echo ====================    $host    ====================
    ssh $host $@
done
#!/bin/bash

#事务日志
dataLogDir=/export/zk/log/version-2
#保留30个文件
count=30
count=$[$count+1]
ls -t $dataLogDir/log.* | tail -n +$count | xargs rm -f

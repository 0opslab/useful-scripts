#!/bin/bash

# 每N秒中执行一次


INTERVAL=10

while : do
  timestr=$(date "+%Y-%m-%d %H:%M:%S")
  redisInfo=$(/xx/redis-cli -h localhost -p 6379 -a password info)
  echo "===========" >> xx/redis-info.txt
  echo $timestr >> /xx/redis-info.txt
  echo $redisInfo >> xx/redis-info.txt
  echo "===========" >> xx/redis-info.txt
  sleep $INTERVAL
done

#! /bin/bash
#@summary: 建议将该问加入到/etc/profile文件中，该文真的会经常用到

#@func - 通过netstat统计各个状态的信息
# LAST_ACK 5   (正在等待处理的请求数) 
# SYN_RECV 30 
# ESTABLISHED 1597 (正常数据传输状态) 
# FIN_WAIT1 51 
# FIN_WAIT2 504 
# TIME_WAIT 1057 (处理完毕，等待超时结束的请求数) 
netstatinfo(){
    netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
}

#@func - 通过定期读取/sys/class/net/eth0/statistics/rx和tx系列的包 显示网络的负载情况
netspeed(){
	INTERVAL="1"  # update interval in seconds
 
	if [ -z "$1" ]; then
	        echo
	        echo usage: $0 [network-interface]
	        echo
	        echo e.g. $0 eth0
	        echo
	        exit
	fi
	 
	IF=$1
	 
	while true
	do
	        R1=`cat /sys/class/net/$1/statistics/rx_bytes`
	        T1=`cat /sys/class/net/$1/statistics/tx_bytes`
	        sleep $INTERVAL
	        R2=`cat /sys/class/net/$1/statistics/rx_bytes`
	        T2=`cat /sys/class/net/$1/statistics/tx_bytes`
	        TBPS=`expr $T2 - $T1`
	        RBPS=`expr $R2 - $R1`
	        TKBPS=`expr $TBPS / 1024`
	        RKBPS=`expr $RBPS / 1024`
	        echo "TX $1: $TKBPS kb/s RX $1: $RKBPS kb/s"
	done
}


#@func - 查看最消耗CPU的进程
cputop(){
    HEADCOUNT = "10"
    HEADCOUNT = $1
    ps auxw|head -1;ps auxw|sort -rn -k3|head -HEADCOUNT
}

#@func - 查看最消耗内存的进程
memtop(){}{
    HEADCOUNT = "10"
    HEADCOUNT = $1
    ps auxw|head -1;ps auxw|sort -rn -k4|head -10
}

#@func - 虚拟内存使用最多的前N个进程 
cache(){}{
    HEADCOUNT = "10"
    HEADCOUNT = $1
    ps auxw|head -1;ps auxw|sort -rn -k5|head -10
}
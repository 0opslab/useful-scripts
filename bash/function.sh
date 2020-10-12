# cat function.sh >> ~/.bashrc



# User specific aliases and functions
#@func - 通过netstat统计各个状态的信息
net_count(){
	# LAST_ACK 5   (正在等待处理的请求数)
	# SYN_RECV 30
	# ESTABLISHED 1597 (正常数据传输状态)
	# FIN_WAIT1 51
	# FIN_WAIT2 504
	# TIME_WAIT 1057 (处理完毕，等待超时结束的请求数)
	netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
}

#@func - # 通过定期读取/sys/class/net/eth0/statistics/rx和tx系列的包 显示网络的负载情况
netspeed(){
	# update interval in seconds
	INTERVAL="1"
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

#@func - 生成指定目录下的文件hash信息
hash_dir(){
	log_file="./"`date +%Y%m%d_%H`"_hash.log"
	for file in `ls $1`
	do
		if [ -d $1"/"$file ] 
		then
			hash_dir $1"/"$file
		else
			hash=`md5sum $1"/"$file`
			echo $hash >> $log_file
		fi
	done
}

#@func - 查看知道进程的句柄和线程数
proc_info(){
	if [ -z "$1" ]; then
		echo
		echo 查看指定进程的信息
		echo 	usage: proc_info pid
		echo
		return
	fi
	echo pid info: ${1} 
	echo fleinfo:
	lsof -p 25758 | grep 'REG  ' | grep  -v 'mem    REG'	
	#echo exefile: `ll /proc/${1}/exe`
	#echo cwd: `ls /proc/${1}/cwd`
	echo proc-status================
	head -28 /proc/${1}/status
	echo proc-tcp===================
	lsof -p ${1} -nP | grep TCP
	echo proc-udp===================
	lsof -p ${1} -nP | grep UDP
}

#@func - 查看cpu信息
cpu_info(){
	echo CPU型号: `cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c`
	echo CPU个数: `cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l`
	echo CPU核数: `cat /proc/cpuinfo| grep "cpu cores"| uniq`
	echo 逻辑CPU总数: `cat /proc/cpuinfo| grep "processor"| wc -l`
	echo "=======系统整体的 CPU利用率和闲置率========="
	grep "cpu " /proc/stat | awk -F ' ' '{total = $2 + $3 + $4 + $5} END {print "idle \t used\n" $5*100/total "% " $2*100/total "%"}'
	echo "=======使用CPU最多的3个进程================"
	ps -aeo pcpu,user,pid,cmd | sort -nr | head -3
}

#@func - 查看io信息
io_info(){
	echo 通过top命令可以粗略的看出IO的大致情况
	echo		us：用户态使用的cpu时间比
	echo		sy：系统态使用的cpu时间比
	echo		ni：用做nice加权的进程分配的用户态cpu时间比
	echo		id：空闲的cpu时间比
	echo		wa：cpu等待磁盘写入完成时间
	echo		hi：硬中断消耗时间
	echo		si：软中断消耗时间
	echo		st：虚拟机偷取时间
}
#@func - 按照 Swap 分区的使用情况列出前 10 的进程
proc_swap(){
	for file in /proc/*/status ; do awk '/VmSwap|Name|^Pid/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 3 -n -r | head -10
}

#@function -在指定目录中查找最大的N个文件 
file_max(){
	if [ -z "$1" ]; then
		echo
		echo "从指定的目录中查找最大的N个文件 usage:file_max path count"
		exit
	fi
	count=$2
	if [ -z "$2" ]; then
		count=10
	fi

	find $1 -type f -print0 | xargs -0 du -h | sort -rh | head -n $count
}


#@func - 显示指定Java进程的信息
java_info(){
	#显示最后一次或当前正在发生的垃圾收集的诱发原因
	jstat -gccause $pid

	#显示各个代的容量及使用情况
	jstat -gccapacity $pid

	#显示新生代容量及使用情况
	jstat -gcnewcapacity $pid

	#显示老年代容量
	jstat -gcoldcapacity $pid

	#显示垃圾收集信息（间隔1秒持续输出）
	#jstat -gcutil $pid 1000

	#按线程状态统计线程数(加强版)
	jstack $pid | grep java.lang.Thread.State:|sort|uniq -c | awk '{sum+=$1; split($0,a,":");gsub(/^[ \t]+|[ \t]+$/, "", a[2]);printf "%s: %s\n", a[2], $1}; END {printf "TOTAL: %s",sum}';

	# 查看堆内对象的分布 Top 50（定位内存泄漏）
	jmap –histo:live $pid | sort-n -r -k2 | head-n 50

}

<<<<<<< HEAD
#@func - 获取用户指定用户的进程PID=`GetPID root TestApp` echo $PID
function GetPID(){
 PsUser=$1
 PsName=$2
 pid=`ps -u $PsUser|grep $PsName|grep -v grep|grep -v vi|grep -v dbx | grep -v tail|grep -v start|grep -v stop |sed -n 1p |awk '{print $1}'`
 echo $pid
}
=======


>>>>>>> 14a775bf3bab42c01e750e35a9aa293fd25ab015


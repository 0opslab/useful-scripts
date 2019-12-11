#!/usr/bin/env bash

usage="usage: $0 \n
系统资源监控: 记录cpu\memory\load\gpu\disk, 入库influxdb, 当超过规定数值时发电邮通知管理员
recommend: run by crontab
"

# *** config start ***

# 当前服务器名
HOST=$(hostname)

ROOT='/var/log/monitor'

INFLUXDB_HOST='127.0.0.1'
INFLUXDB_PORT=8086

# 当前目录路径

# log 文件路径
CPU_LOG="${ROOT}/cpu.log"
MEM_LOG="${ROOT}/mem.log"
LOAD_LOG="${ROOT}/load.log"
GPU_LOG="${ROOT}/gpu.log"
RENDERER_LOG="${ROOT}/renderer.log"

# 通知电邮列表
NOTICE_EMAIL='admin@admin.com'

# cpu,memory,load average 记录上一次发送通知电邮时间
CPU_REMARK='/tmp/servermonitor_cpu.remark'
MEM_REMARK='/tmp/servermonitor_mem.remark'
LOAD_REMARK='/tmp/servermonitor_loadaverage.remark'
GPU_REMARK='/tmp/servermonitor_gpu.remark'

# 发通知电邮间隔时间
REMARK_EXPIRE=3600
NOW=$(date +%s)

LIMIT_CPU=8
LIMIT_MEM=80
LIMIT_LOAD=35
LIMIT_GPU=80

FDISK='/dev/sda5'


# *** function start ***

# 获取CPU占用
function GetCpu() {
    cpufree=$(vmstat 1 5 |sed -n '3,$p' |awk '{x = x + $15} END {print x/5}' |awk -F. '{print $1}')
    cpuused=$((100 - $cpufree))
    echo $cpuused
    # curl -i -XPOST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=monitordb" --data-binary "cpu,host=${HOST} used=${cpuused}"

    local remark
    remark=$(GetRemark ${CPU_REMARK})

    # 检查CPU占用是否超过90%
    if [ "$remark" = "" ] && [ "$cpuused" -gt ${LIMIT_CPU} ]; then
        echo "CPU uses more than ${LIMIT_CPU}%" | CustomSendMail ${NOTICE_EMAIL}
        echo "$(date +%s)" > "$CPU_REMARK"
    fi
}

# 获取内存使用情况
function GetMem() {
    mem=$(free -m | sed -n '3,3p')
    used=$(echo $mem | awk -F ' ' '{print $3}')
    free=$(echo $mem | awk -F ' ' '{print $4}')
    total=$(($used + $free))
    limit=$(($total/10))
    echo "${total} ${used} ${free}"
    # curl -i -XPOST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=monitordb" --data-binary "mem,host=${HOST} used=${used},total=${total}"

    local remark
    remark=$(GetRemark ${MEM_REMARK})

    # 检查内存占用是否超过90%
    if [ "$remark" = "" ] && [ "$used" -gt "${LIMIT_MEM}" ]; then
        echo "Memory uses more than ${LIMIT_MEM}%" | CustomSendMail ${NOTICE_EMAIL}
        echo "$(date +%s)" > "$MEM_REMARK"
    fi
}

# 获取load average
function GetLoad() {
    load=$(uptime | awk -F 'load average: ' '{print $2}')
    m1=$(echo $load | awk -F ', ' '{print $1}')
    m5=$(echo $load | awk -F ', ' '{print $2}')
    m15=$(echo $load | awk -F ', ' '{print $3}')
    echo "${m1} ${m5} ${m15}"
    #curl -i -XPOST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=monitordb" --data-binary "load,host=${HOST} m1=${m1},m5=${m5},m15=${m15},cores=40"

    local remark
    remark=$(GetRemark ${LOAD_REMARK})

    # 检查是否负载是否有压力
    if [ "$remark" = "" ] && [ "$m1" -gt "${LIMIT_LOAD}" ]; then
        echo "Load Average more than ${LIMIT_LOAD}" | CustomSendMail ${NOTICE_EMAIL}
        echo "$(date +%s)" > "$LOAD_REMARK"
    fi
}

# 获取GPU利用率
function GetGpu() {
    used=`nvidia-smi --query-gpu=utilization.gpu --format=csv | grep -v 'utilization' | awk '{print $1}'`
    no=0
    total_used=0
    total_num=0
    params=""
    for i in ${used};
    do
        gpu_array[${no}]=${i}
        params="${params},used${no}=${i}"
        let no+=1
        let total_used+=${i}
        let total_num+=1
    done
    echo "$total_used/$total_num"
    gpu_average=$(($total_used/$total_num))
    echo "${used} $gpu_average"

    #curl -i -XPOST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=monitordb" --data-binary "gpu,host=${HOST} used=${gpu_average}${params}"

    local remark
    remark=$(GetRemark ${GPU_REMARK})
    # 检查GPU使用率
    if [ "$remark" = "" ] && [ "${gpu_average}" -gt "${LIMIT_GPU}" ]; then
        echo "GPU more than ${LIMIT_GPU}%" | CustomSendMail ${NOTICE_EMAIL}
        echo "$(date +%s)" > "GPU_REMARK"
    fi
}

# 获取磁盘使用率
function GetStorage() {

    #disk_info=$(df -h | grep "`cat /etc/fstab | grep '/dev/' | grep -v swap |  grep -v boot | awk '{print $1}' | grep -v '#'`")

    #要将$FDISK分割开，先存储旧的分隔符
    OLD_IFS="$IFS"
    #设置分隔符
    IFS=","
    #如下会自动分隔
    arr=($FDISK)
    #恢复原来的分隔符
    IFS="$OLD_IFS"

    #遍历数组
    for s in ${arr[@]}
    do
        params=`df -h | grep "$s" | awk '{print "total="$2",per="$5",used="$3}' | sed 's/%//' | sed 's/G//g'`
        echo $params
        #curl -i -XPOST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=monitordb" --data-binary "disk,host=${HOST},dev=${s} ${params}"
    done
}


# 获取上一次发送电邮时间
function GetRemark() {
    local remark

    if [ -f "$1" ] && [ -s "$1" ]; then
        remark=$(cat $1)

        if [ $(( $NOW - $remark )) -gt "$REMARK_EXPIRE" ]; then
            rm -f $1
            remark=""
        fi
    else
        remark=""
    fi

    echo $remark
}

function CustomSendMail() {
    # 可以调用集群公共邮件服务
    sendmail "Subject: ${HOST} $1 $(date +%Y-%m-%d' '%H:%M:%S)"
}

# *** run start ***

cpuinfo=$(GetCpu)
meminfo=$(GetMem)
loadinfo=$(GetLoad)
gpuinfo=$(GetGpu)
storageinfo=$(GetStorage)

echo "[$(date)] cpu: ${cpuinfo}"                        # | tee -a "${CPU_LOG}"
echo "[$(date)] mem: ${meminfo}"                        # | tee -a "${MEM_LOG}"
echo "[$(date)] load: ${loadinfo}"                      # | tee -a "${LOAD_LOG}"
echo "[$(date)] gpu: ${gpuinfo}"                        # | tee -a "${GPU_LOG}"
echo "[$(date)] storage: ${storageinfo}"                # | tee -a "${GPU_LOG}"



# /bin/bash 防暴力破解登录
file="denyHosts.txt"
limit=3

# 监控日志并在临时文件记录
if [ ! -f "$file" ]
then
        touch "$file"
fi
cat /var/log/auth.log | awk '/Failed/{print $(NF-3)}' | sort | uniq -c | sort -nr | awk '{print $1"-"$2}' > $file

# 写入系统文件
for i in `cat $file`
do
        num=`echo $i | awk -F- '{print int($1)}'`
        ip=`echo $i | awk -F- '{print $2}'`
        if [ "$num" -ge "$limit" ]
        then
                ipExist=`grep $ip /etc/hosts.deny -w`
                if [ -z "$ipExist" ]  #匹配内容为空
                then
                        echo "sshd:$ip" >> /etc/hosts.deny
                fi
        fi
done
rm $file

# 重启sshd服务 
sudo service sshd restart
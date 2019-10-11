#!/bin/bash
#
# Github repo: https://github.com/joychao/tools
#
# 本脚本包含数据库自动备份功能，导出sql并gzip压缩
# 可选邮件自动发送到指定邮箱（需要安装sendEmail）
# ! 目前不兼容OS X
#
# 安装sendEmail:
#   $ wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v1.56.tar.gz
#   $ tar -zxvf sendEmail-v1.56.tar.gz && cd sendEmail-v1.56
#   $ cp sendEmail /usr/bin
#   $ chmod 0755 /usr/bin/sendEmail
#
# ------------------------------------------------------------------------------------------------
# 说明：
#   1.此脚本运行时会报:Warning: Using a password on the command line interface can be insecure.
#    解决方法：
#    vim /etc/mysql/my.cnf
#    [mysqldump]
#    user=your_backup_user_name
#    password=your_backup_password
#    重启mysqld
# ------------------------------------------------------------------------------------------------

#保留几天内的备份
KEEP_DAY=5
# 存档名称
FILE_PREFIX="backup_"
# 备份存档目录
BACKUP_DIR="/home/db_backup/"
# 新备份文件名
NEW_FILE="$BACKUP_DIR/$FILE_PREFIX$(date +%Y-%m-%d_%H%M%S).gz"
# mysqldump所在路径
MYSQLDUMP="/usr/local/mysql/bin/mysqldump"
# 需要备份的数据库
DATABASES="test"
# 数据库用户名
DB_USER="root"
# 数据库密码
DB_PASSWORD="123456"
# 备份日志
BACKUP_LOG="/home/db_backup.log"

# --------- 邮件配置 -----------
# 发送邮件？
MAIL_BACKUP=1
# smtp主机,SERVER[:PORT]
MAIL_SMTP_HOST="smtp.gmail.com:587"
# stmp账号密码
MAIL_SMTP_USER="yboker1982@gmail.com"
MAIL_SMTP_PASS="123456"
# 发件人,如果使用QQ邮箱，发件人要与上面MAIL_SMTP_USER一样
MAIL_SENDER="yboker1982@gmail.com"
# 收件人，多个请用空格分开
MAIL_RECEVER="8236138@qq.com"
# 抄送，多个请用空格分开
MAIL_CC=""
# 邮件主题
MAIL_SUBJECT="[$DATABASES]的数据库备份 - `date +%Y年%m月%d日%H:%M`"
# 邮件内容
MAIL_MESSAGE="[$DATABASES]的数据库备份 - `date +%Y年%m月%d日%H:%M`"
#使用 TLS(yes|no)
MAIL_TLS=yes

# ------------------- 以下请勿轻易修改 -----------------------------------
# 旧文件名
OLD_FILE=$BACKUP_DIR/$FILE_PREFIX$(date +%Y-%m-%d_%H%M%S --date="$KEEP_DAY days ago").gz

# 删除旧文件
if [ -f $OLD_FILE ]
then
   rm -f $OLD_FILE >> $BACKUP_LOG 2>&1
   echo "[$OLD_FILE]删除旧文件成功!" >> $BACKUP_LOG
else
   echo "[$OLD_FILE]没有旧文件!" >> $BACKUP_LOG
fi

# 创建备份
if [ -f $NEW_FILE ]
then
   echo "[$NEW_FILE]文件已经存在!" >> $BACKUP_LOG
else
    $MYSQLDUMP --databases $DATABASES -u$DB_USER -p$DB_PASSWORD | gzip > $NEW_FILE
    echo "[$NEW_FILE]备份完成!" >> $BACKUP_LOG
    if [ MAIL_BACKUP ]
    then
       sendEmail -f $MAIL_SENDER -t $MAIL_RECEVER -s $MAIL_SMTP_HOST -u "$MAIL_SUBJECT" -a "$NEW_FILE" -m "$MAIL_MESSAGE" -xu "$MAIL_SMTP_USER" -xp "$MAIL_SMTP_PASS" -cc "$MAIL_CC" >> $BACKUP_LOG
    fi
fi

#end

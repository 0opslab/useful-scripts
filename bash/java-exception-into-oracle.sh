#!/bin/bash

echo "#!/bin/bash" >sqlplus_load.bash
echo "sqlplus -s /nolog > runlog <<EOF" >sqlplus_load.bash
echo "conn qhmcc/XWsptyapp123#@XWTEST26DB">>sqlplus_load.bash

echo "declare v_clob clob:=''||">>sqlplus_load.bash
find /webapp02/bes820/var/domains/domain1/nodes/ -name server.log | xargs grep 'at com.xwte' | grep -v '#' | awk '{ print $3 }' | sort | uniq -c | sort -n -r | sed "s/^/'&/g" | sed "s/$/'||cha(10)/g">>sqlplus_load.bash
echo "'';">>sqlplus_load.bash

echo "begin">>sqlplus_load.bash
echo "    insert into t_runtime_exception(createtime,serverip,content) values(sysdate,'135.191.168.68',v_clob);">>sqlplus_load.bash
echo "end;">>sqlplus_load.bash
echo "/">>sqlplus_load.bash
echo "commit;">>sqlplus_load.bash
echo "exit">>sqlplus_load.bash
echo "EOF">>sqlplus_load.bash
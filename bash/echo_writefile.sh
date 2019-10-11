# !/bin/bash

#
#在需要时间字符串的地方直接写上$date或${date}
#
date1=`date +"%Y%m%d"`
date2=`date +"%Y-%m-%d %H:%m:%S"`
filename="email_"${date}"_1.eh"
#rm -rdf $(filename}
touch ${filename}

echo "<D5000工作流::传输说明 time='${date2}'>" >  ${filename}
echo "@#顺序 属性名 属性值" >>  ${filename}
echo "#0 标识 IR_DATAEXTEST_V005_1010282028383746.wf" >>  ${filename}
echo "#1 发送地址 国调2.WF" >>  ${filename}
echo "#2 接收地址 国调3.WF" >>  ${filename}
echo "#3 传输类型 文件" >>  ${filename}
echo "#4 内容 ''" >>  ${filename}
echo "#5 文件 'IR_DATAEXTEST_V005_1010282028383746.wf'" >>  ${filename}
echo "#6 状态 '到达国调3.WF'" >>  ${filename}
echo "</D5000工作流::传输说明>" >>  ${filename}

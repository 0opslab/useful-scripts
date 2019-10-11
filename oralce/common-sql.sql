--随机返回表中的一条记录
select * from (select * from 表名 order by dbms_random.value) where rownum<=1;
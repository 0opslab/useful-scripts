-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/top_sql.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays a list of SQL statements that are using the most resources.
-- Comments     : The address column can be use as a parameter with SQL_Text.sql to display the full statement.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @top_sql (number)
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET LINESIZE 500
SET PAGESIZE 1000
SET VERIFY OFF

SELECT *
FROM   (SELECT Substr(a.sql_text,1,50) sql_text,
               Trunc(a.disk_reads/Decode(a.executions,0,1,a.executions)) reads_per_execution, 
               a.buffer_gets, 
               a.disk_reads, 
               a.executions, 
               a.sorts,
               a.address
        FROM   v$sqlarea a
        ORDER BY 2 DESC)
WHERE  rownum <= &&1;

SET PAGESIZE 14

-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/pipes.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays a list of all database pipes.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @pipes
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET LINESIZE 500
SET PAGESIZE 1000
SET VERIFY OFF

SELECT a.ownerid "Owner",
       Substr(name,1,40) "Name",
       type "Type",
       pipe_size "Size"
FROM   v$db_pipes a
ORDER BY 1,2;

SET PAGESIZE 14
SET VERIFY ON
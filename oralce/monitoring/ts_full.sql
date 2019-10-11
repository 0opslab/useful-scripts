-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/ts_full.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays a list of tablespaces that are nearly full.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @ts_full
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET PAGESIZE 1000
SET LINESIZE 255
SET FEEDBACK OFF

PROMPT
PROMPT Tablespaces nearing 0% free
PROMPT ***************************
SELECT a.tablespace_name,
       b.size_kb,
       a.free_kb,
       Trunc((a.free_kb/b.size_kb) * 100) "FREE_%"
FROM   (SELECT tablespace_name,
               Trunc(Sum(bytes)/1024) free_kb
        FROM   dba_free_space
        GROUP BY tablespace_name) a,
       (SELECT tablespace_name,
               Trunc(Sum(bytes)/1024) size_kb
        FROM   dba_data_files
        GROUP BY tablespace_name) b
WHERE  a.tablespace_name = b.tablespace_name
AND    Round((a.free_kb/b.size_kb) * 100,2) < 10
/

PROMPT
SET FEEDBACK ON
SET PAGESIZE 18
                       
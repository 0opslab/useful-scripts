-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/show_tables.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays information about specified tables.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @show_tables (schema)
-- Last Modified: 04/10/2006
-- -----------------------------------------------------------------------------------
SET VERIFY OFF
SET LINESIZE 200

SELECT table_name,
       tablespace_name,
       num_rows,
       avg_row_len,
       blocks,
       empty_blocks
FROM   dba_tables
WHERE  owner = UPPER('&1')
ORDER BY table_name;

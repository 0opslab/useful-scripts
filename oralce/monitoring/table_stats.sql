-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/table_stats.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays the table statistics belonging to the specified schema.
-- Requirements : Access to the DBA and v$ views.
-- Call Syntax  : @table_stats (schema-name or all)
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SELECT t.table_name AS "Table Name", 
       t.num_rows AS "Rows", 
       t.avg_row_len AS "Avg Row Len", 
       Trunc((t.blocks * p.value)/1024) AS "Size KB", 
       t.last_analyzed AS "Last Analyzed"
FROM   dba_tables t,
       v$parameter p
WHERE t.owner = Decode(Upper('&1'), 'ALL', t.owner, Upper('&1'))
AND   p.name = 'db_block_size'
ORDER by t.table_name;


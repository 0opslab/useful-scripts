-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/code_dep.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays all dependencies of specified object.
-- Call Syntax  : @code_dep (object-name) (schema-name or all)
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 255
SET PAGESIZE 1000
BREAK ON type SKIP 1
PROMPT

SELECT a.referenced_type AS type,
       SUBSTR(a.referenced_owner,1,10) AS ref_owner,
       a.referenced_name AS ref_name,
       SUBSTR(a.referenced_link_name,1,20) AS ref_link_name
FROM   all_dependencies a
WHERE  a.name  = Upper('&1')
AND    a.owner = DECODE(UPPER('&2'), 'ALL', a.referenced_owner, UPPER('&2'))
ORDER BY 1,2,3;

SET VERIFY ON
SET FEEDBACK ON
SET PAGESIZE 22
PROMPT

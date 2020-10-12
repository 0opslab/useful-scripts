-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/code_dep_on.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays all objects dependant on the specified object.
-- Call Syntax  : @code_dep_on (object-name) (schema-name or all)
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 255
SET PAGESIZE 1000
BREAK ON type SKIP 1
PROMPT

SELECT a.type,
       SUBSTR(a.owner,1,10) AS owner,
       a.name
FROM   all_dependencies a
WHERE  a.referenced_name  = UPPER('&1')
AND    a.referenced_owner = DECODE(UPPER('&2'), 'ALL', a.referenced_owner, UPPER('&2'))
ORDER BY 1,2,3;

SET VERIFY ON
SET FEEDBACK ON
SET PAGESIZE 22
PROMPT

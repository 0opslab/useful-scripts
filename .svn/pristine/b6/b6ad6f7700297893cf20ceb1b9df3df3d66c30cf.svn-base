-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/access.sql
-- Author       : DR Timothy S Hall
-- Description  : Lists all objects being accessed in the schema.
-- Call Syntax  : @access (schema-name)
-- Requirements : Access to the v$views.
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET LINESIZE 255
SET VERIFY OFF

COLUMN object FORMAT A30

SELECT a.object,
       a.type,
       a.sid,
       b.username,
       b.osuser,
       b.program
FROM   v$access a,
       v$session b
WHERE  a.sid   = b.sid
AND    a.owner = UPPER('&1')
ORDER BY a.object;


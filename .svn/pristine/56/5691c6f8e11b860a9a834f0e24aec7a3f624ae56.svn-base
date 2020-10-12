-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/invalid_objects.sql
-- Author       : DR Timothy S Hall
-- Description  : Lists all invalid objects in the database.
-- Call Syntax  : @invalid_objects
-- Requirements : Access to the DBA views.
-- Last Modified: 18/12/2005
-- -----------------------------------------------------------------------------------
COLUMN object_name FORMAT A30
SELECT owner,
       object_type,
       object_name,
       status
FROM   dba_objects
WHERE  status = 'INVALID'
ORDER BY owner, object_type, object_name;

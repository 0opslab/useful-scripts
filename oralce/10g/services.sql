-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/10g/services.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays information about database services.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @services
-- Last Modified: 05/11/2004
-- -----------------------------------------------------------------------------------
SET LINESIZE 200
COLUMN name FORMAT A30
COLUMN network_name FORMAT A50

SELECT name,
       network_name
FROM   dba_services
ORDER BY name;
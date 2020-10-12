-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/resource_manager/active_plan.sql
-- Author       : DR Timothy S Hall
-- Description  : Lists the currently active resource plan if one is set.
-- Call Syntax  : @active_plan
-- Requirements : Access to the v$ views.
-- Last Modified: 12/11/2004
-- -----------------------------------------------------------------------------------
SELECT name,
       is_top_plan
FROM   v$rsrc_plan
ORDER BY name;

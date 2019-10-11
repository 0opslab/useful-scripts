-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/roles.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays a list of all roles and priviliges granted to the specified user.
-- Requirements : Access to the USER views.
-- Call Syntax  : @roles
-- Last Modified: 15/07/2000
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF

SELECT a.granted_role "Role",
       a.admin_option "Adm"
FROM   user_role_privs a;

SELECT a.privilege "Privilege",
       a.admin_option "Adm"
FROM   user_sys_privs a;
               
SET VERIFY ON

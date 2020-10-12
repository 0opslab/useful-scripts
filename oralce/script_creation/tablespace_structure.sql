-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/tablespace_structure.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for the specified tablespace, or all tablespaces.
-- Call Syntax  : @tablespace_structure (tablespace-name or all)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 100
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_ts IS
        SELECT *
        FROM   dba_tablespaces a
        WHERE  a.tablespace_name  = Decode(Upper('&&1'), 'ALL',a.tablespace_name, Upper('&&1'))
        ORDER BY a.tablespace_name;
 
    CURSOR cu_df (p_tablespace  IN  VARCHAR2) IS
        SELECT *
        FROM   dba_data_files a
        WHERE  a.tablespace_name = p_tablespace
        ORDER BY a.file_name;

BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);

    FOR cur_ts IN cu_ts LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating Tablespace ' || cur_ts.tablespace_name);
        DBMS_Output.Put_Line('CREATE TABLESPACE ' || Lower(cur_ts.tablespace_name));
        DBMS_Output.Put_Line('DATAFILE');
        FOR cur_df IN cu_df (p_tablespace => cur_ts.tablespace_name) LOOP
            IF cu_df%ROWCOUNT != 1 THEN
                DBMS_Output.Put_Line(',');
            END IF;
            DBMS_Output.Put('	''' || cur_df.file_name || ''' SIZE ' || Trunc(cur_df.bytes/1024) || 'K');
        END LOOP;
        DBMS_Output.Put_Line(' ');
        DBMS_Output.Put_Line(cur_ts.status);
        DBMS_Output.Put_Line(cur_ts.contents);
        DBMS_Output.Put_Line('/');        
        DBMS_Output.Put_Line('	');        
    END LOOP;

    DBMS_Output.Put_Line('	');

END;
/

SET VERIFY ON
SET FEEDBACK ON
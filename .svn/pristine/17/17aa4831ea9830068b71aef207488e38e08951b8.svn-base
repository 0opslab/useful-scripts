-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/view_structure.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for the specified view.
-- Call Syntax  : @view_structure (view-name) (schema-name)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_view IS
        SELECT *
        FROM   all_views a
        WHERE  a.view_name   = Upper('&&1')
        AND    a.owner       = Upper('&&2');
 
    CURSOR cu_tab_com IS
        SELECT a.table_name,
               a.comments
        FROM   all_tab_comments a
        WHERE  a.table_name = Upper('&&1')
        AND    a.owner      = Upper('&&2');

    CURSOR cu_col_com IS
        SELECT a.table_name,
               a.column_name,
               a.comments
        FROM   all_col_comments a
        WHERE  a.table_name = Upper('&&1')
        AND    a.owner      = Upper('&&2');

BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);

    FOR cur_view IN cu_view LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating View ' || cur_view.view_name);
        DBMS_Output.Put_Line('CREATE OR REPLACE VIEW ' || Lower(cur_view.view_name) || ' AS');
        DBMS_Output.Put_Line(cur_view.text || '/');
        DBMS_Output.Put_Line('	');        
    END LOOP;

    FOR cur_tab_com IN cu_tab_com LOOP
        DBMS_Output.Put_Line('COMMENT ON TABLE ' || Lower(cur_tab_com.table_name) || ' IS ''' || cur_tab_com.comments || ''';');
    END LOOP;

    DBMS_Output.Put_Line('	');

    FOR cur_col_com IN cu_col_com LOOP
        DBMS_Output.Put_Line('COMMENT ON COLUMN ' || Lower(cur_col_com.table_name || '.' || cur_col_com.column_name) || ' IS ''' || cur_col_com.comments || ''';');
    END LOOP;

    DBMS_Output.Put_Line('	');

END;
/

SET VERIFY ON
SET FEEDBACK ON
-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/table_structure.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for specified table, or all tables.
-- Call Syntax  : @table_structure (table-name or all) (schema)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 300
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_tab IS
        SELECT a.table_name,
               a.pct_free,
               a.pct_used,
               a.ini_trans,
               a.max_trans,
               a.tablespace_name,
               a.initial_extent,
               a.next_extent,
               a.min_extents,
               a.max_extents,
               a.pct_increase
        FROM   all_tables a
        WHERE  a.table_name  = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND    a.owner       = Upper('&&2');
 
    CURSOR cu_col (in_table  IN  VARCHAR2) IS
        SELECT a.column_name,
               a.data_type,
               Decode(a.data_scale,NULL,'',0,'',',' || To_Char(a.data_scale)) data_scale,
               To_Char(a.data_length) data_length,
               To_Char(a.data_precision) data_precision,
               Decode(a.nullable,'Y','NULL','N','NOT NULL') nullable
        FROM   all_tab_columns a
        WHERE  a.table_name  = in_table
        AND    a.owner       = Upper('&&2');

    CURSOR cu_tab_com IS
        SELECT a.table_name,
               a.comments
        FROM   all_tab_comments a
        WHERE  a.table_name = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND    a.owner      = Upper('&&2')
        AND    a.comments  IS NOT NULL;

    CURSOR cu_col_com IS
        SELECT a.table_name,
               a.column_name,
               a.comments
        FROM   all_col_comments a
        WHERE  a.table_name = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND    a.owner      = Upper('&&2')
        AND    a.comments  IS NOT NULL;

BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);
    DBMS_Output.Put_Line('PROMPT');
    DBMS_Output.Put_Line('PROMPT Script does not cope with DEFAULT VALUES or Check Constraints');

    FOR cur_tab IN cu_tab LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating Table ' || cur_tab.table_name);
        DBMS_Output.Put_Line('CREATE TABLE ' || Lower(cur_tab.table_name));
        DBMS_Output.Put_Line('(');
        FOR cur_col IN cu_col (in_table => cur_tab.table_name) LOOP
            IF cu_col%ROWCOUNT != 1 THEN
                DBMS_Output.Put_Line(',');
            END IF;
            IF cur_col.data_type = 'DATE' THEN
                DBMS_Output.Put(RPad(Lower(cur_col.column_name),30,' ') || '	' || RPad(cur_col.data_type,20,' ') || '	' || cur_col.nullable);     
            ELSIF cur_col.data_type = 'NUMBER' THEN
                DBMS_Output.Put(RPad(Lower(cur_col.column_name),30,' ') || '	' || RPad(cur_col.data_type || '(' || cur_col.data_precision || cur_col.data_scale || ')',20,' ') || '	' || cur_col.nullable);     
            ELSE
                DBMS_Output.Put(RPad(Lower(cur_col.column_name),30,' ') || '	' || RPad(cur_col.data_type || '(' || cur_col.data_length || ')',20,' ') || '	' || cur_col.nullable);     
            END IF;
        END LOOP;
        DBMS_Output.Put_Line('	');
        DBMS_Output.Put_Line(')');
        DBMS_Output.Put_Line('PCTFREE	' || cur_tab.pct_free);
        DBMS_Output.Put_Line('PCTUSED	' || cur_tab.pct_used);
        DBMS_Output.Put_Line('INITRANS	' || cur_tab.ini_trans);
        DBMS_Output.Put_Line('MAXTRANS	' || cur_tab.max_trans);
        DBMS_Output.Put_Line('TABLESPACE	' || cur_tab.tablespace_name);
        DBMS_Output.Put_Line('STORAGE	(');
        DBMS_Output.Put_Line('		INITIAL     ' || Trunc(cur_tab.initial_extent/1024) || 'K');
        DBMS_Output.Put_Line('		NEXT        ' || Trunc(cur_tab.next_extent/1024) || 'K');
        DBMS_Output.Put_Line('		MINEXTENTS  ' || cur_tab.min_extents);
        DBMS_Output.Put_Line('		MAXEXTENTS  ' || cur_tab.max_extents);
        DBMS_Output.Put_Line('		PCTINCREASE ' || cur_tab.pct_increase);
        DBMS_Output.Put_Line('	)');
        DBMS_Output.Put_Line('/');        
        DBMS_Output.Put_Line('	');        
    END LOOP;

    DBMS_Output.Put_Line('PROMPT');
    DBMS_Output.Put_Line('PROMPT Creating Table Comment');
    FOR cur_tab_com IN cu_tab_com LOOP
        DBMS_Output.Put_Line('COMMENT ON TABLE ' || Lower(cur_tab_com.table_name) || ' IS ''' || cur_tab_com.comments || ''';');
    END LOOP;

    DBMS_Output.Put_Line('	');

    DBMS_Output.Put_Line('PROMPT');
    DBMS_Output.Put_Line('PROMPT Creating Column Comments');
    FOR cur_col_com IN cu_col_com LOOP
        DBMS_Output.Put_Line('COMMENT ON COLUMN ' || Lower(cur_col_com.table_name || '.' || cur_col_com.column_name) || ' IS ''' || cur_col_com.comments || ''';');
    END LOOP;

    DBMS_Output.Put_Line('	');

END;
/

SET VERIFY ON
SET FEEDBACK ON
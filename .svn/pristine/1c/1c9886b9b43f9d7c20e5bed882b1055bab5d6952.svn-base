-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/table_indexes.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the index DDL for specified table, or all tables.
-- Call Syntax  : @table_indexes (table-name or all) (schema-name)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 100
SET VERIFY OFF
SET FEEDBACK OFF

DECLARE

    CURSOR cu_idx IS
        SELECT Decode(a.uniqueness,'UNIQUE','UNIQUE ',NULL) AS uniqueness, 
               a.index_name,
               a.table_name,
               a.ini_trans,
               a.max_trans,
               a.pct_free,
               a.tablespace_name,
               a.initial_extent,
               a.next_extent,
               a.min_extents,
               a.max_extents,
               a.pct_increase
        FROM   all_indexes a
        WHERE  a.table_name  = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND    a.table_owner = Upper('&&2')
        AND    NOT EXISTS (SELECT '1'
                           FROM   all_constraints b
                           WHERE  b.constraint_name = a.index_name
                           AND    b.constraint_type = 'P'
                           AND    b.owner           = Upper('&&2'))
        ORDER BY a.index_name;

    CURSOR cu_col (p_idx  IN  VARCHAR2) IS
        SELECT a.column_name
        FROM   all_ind_columns a
        WHERE  a.index_name  = p_idx
        AND    a.index_owner = Upper('&&2')
        ORDER BY a.column_position;

BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);

    FOR cur_idx IN cu_idx LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating Index ' || cur_idx.index_name);
        DBMS_Output.Put_Line('CREATE ' || cur_idx.uniqueness || 'INDEX ' || Lower(cur_idx.index_name));
        DBMS_Output.Put_Line('ON ' || Lower(cur_idx.table_name));
        DBMS_Output.Put_Line('(');
        FOR cur_col IN cu_col (cur_idx.index_name) LOOP
            IF cu_col%ROWCOUNT != 1 THEN
                DBMS_Output.Put_Line(',');
            END IF;
            DBMS_Output.Put('	' || lower(cur_col.column_name));     
        END LOOP;
        DBMS_Output.Put_Line('	');
        DBMS_Output.Put_Line(')');
        DBMS_Output.Put_Line('INITRANS	' || cur_idx.ini_trans);
        DBMS_Output.Put_Line('MAXTRANS	' || cur_idx.max_trans);
        DBMS_Output.Put_Line('PCTFREE	' || cur_idx.pct_free);
        DBMS_Output.Put_Line('TABLESPACE	' || cur_idx.tablespace_name);
        DBMS_Output.Put_Line('STORAGE	(');
        DBMS_Output.Put_Line('		INITIAL     ' || Trunc(cur_idx.initial_extent/1024) || 'K');
        DBMS_Output.Put_Line('		NEXT        ' || Trunc(cur_idx.next_extent/1024) || 'K');
        DBMS_Output.Put_Line('		MINEXTENTS  ' || cur_idx.min_extents);
        DBMS_Output.Put_Line('		MAXEXTENTS  ' || cur_idx.max_extents);
        DBMS_Output.Put_Line('		PCTINCREASE ' || cur_idx.pct_increase);
        DBMS_Output.Put_Line('		)');
        DBMS_Output.Put_Line('/');        
        DBMS_Output.Put_Line('	');        
    END LOOP;

END;
/

SET VERIFY ON
SET FEEDBACK ON
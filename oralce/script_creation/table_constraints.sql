-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/table_constraints.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the UK & PK constraint DDL for specified table, or all tables.
-- Call Syntax  : @table_constraints (table-name or all) (schema-name)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 100
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_con IS
        SELECT *
        FROM   all_constraints a
        WHERE  a.table_name       = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND    a.owner            = Upper('&&2')
        AND    a.constraint_type IN ('U','P')
        ORDER BY a.constraint_name;

    CURSOR cu_idx (p_idx  IN  VARCHAR2) IS
        SELECT *
        FROM   all_indexes a
        WHERE  a.index_name  = p_idx
        AND    a.table_owner = Upper('&&2')
        ORDER BY a.index_name;

    -- ----------------------------------------------------------------------------------------
    FUNCTION Con_Columns(p_tab  IN  VARCHAR2,
                         p_con  IN  VARCHAR2)
        RETURN VARCHAR2 IS
    -- ----------------------------------------------------------------------------------------    
        CURSOR cu_col_cursor IS
            SELECT  a.column_name
            FROM    all_cons_columns a
            WHERE   a.table_name      = p_tab
            AND     a.constraint_name = p_con
            AND     a.owner           = Upper('&&2')
            ORDER BY a.position;
     
        l_result    VARCHAR2(1000);        
    BEGIN    
        FOR cur_rec IN cu_col_cursor LOOP
            IF cu_col_cursor%ROWCOUNT = 1 THEN
                l_result   := cur_rec.column_name;
            ELSE
                l_result   := l_result || ',' || cur_rec.column_name;
            END IF;
        END LOOP;
        RETURN Lower(l_result);        
    END;
    -- ----------------------------------------------------------------------------------------

BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);

    FOR cur_rec IN cu_con LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating Constraint ' || cur_rec.constraint_name);
        DBMS_Output.Put_Line('ALTER TABLE ' || Lower(cur_rec.table_name) || ' ADD');
        DBMS_Output.Put_Line('(');
        DBMS_Output.Put_Line('	CONSTRAINT ' || Lower(cur_rec.constraint_name));
        IF cur_rec.constraint_type = 'U' THEN
            DBMS_Output.Put_Line('	UNIQUE ' || ' ('||Con_Columns(cur_rec.table_name, cur_rec.constraint_name)||')');
        ELSE
            DBMS_Output.Put_Line('	PRIMARY KEY ' || ' ('||Con_Columns(cur_rec.table_name, cur_rec.constraint_name)||')');
        END IF;
        FOR cur_idx IN cu_idx (cur_rec.constraint_name) LOOP
            DBMS_Output.Put_Line('	USING INDEX');
            DBMS_Output.Put_Line('		INITRANS	' || cur_idx.ini_trans);
            DBMS_Output.Put_Line('		MAXTRANS	' || cur_idx.max_trans);
            DBMS_Output.Put_Line('		PCTFREE		' || cur_idx.pct_free);
            DBMS_Output.Put_Line('		TABLESPACE	' || cur_idx.tablespace_name);
            DBMS_Output.Put_Line('		STORAGE	(');
            DBMS_Output.Put_Line('				INITIAL     ' || Trunc(cur_idx.initial_extent/1024) || 'K');
            DBMS_Output.Put_Line('				NEXT        ' || Trunc(cur_idx.next_extent/1024) || 'K');
            DBMS_Output.Put_Line('				MINEXTENTS  ' || cur_idx.min_extents);
            DBMS_Output.Put_Line('				MAXEXTENTS  ' || cur_idx.max_extents);
            DBMS_Output.Put_Line('				PCTINCREASE ' || cur_idx.pct_increase);
            DBMS_Output.Put_Line('			)');
        END LOOP;
        DBMS_Output.Put_Line(')');
        DBMS_Output.Put_Line('/');
        DBMS_Output.Put_Line('	');

    END LOOP;

END;
/

PROMPT
SET VERIFY ON
SET FEEDBACK ON
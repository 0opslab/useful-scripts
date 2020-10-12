-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/fks_on_table.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for the foreign keys on the specified table, or all tables.
-- Call Syntax  : @fks_on_table (table-name or all) (schema)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 100
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_cons IS
        SELECT  a.table_name, 
                a.constraint_name,
                a.r_constraint_name,
                NVL(a.delete_rule,' ') delete_rule,
                NVL(a.status,' ') status
        FROM    all_constraints a
        WHERE   a.table_name        = Decode(Upper('&&1'), 'ALL',a.table_name, Upper('&&1'))
        AND     a.owner             = Upper('&&2')
        AND     a.constraint_type   = 'R'
        ORDER BY a.table_name, a.constraint_name;

  v_r_table_name all_constraints.table_name%TYPE;

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

    FOR cur_rec IN cu_cons LOOP
        SELECT a.table_name
        INTO   v_r_table_name
        FROM   all_constraints a
        WHERE  a.constraint_name = cur_rec.r_constraint_name;

        DBMS_Output.Put_Line('ALTER TABLE '||Lower(cur_rec.table_name)||' ADD');
        DBMS_Output.Put_Line('	(');
        DBMS_Output.Put_Line('	CONSTRAINT '||Lower(cur_rec.constraint_name));
        DBMS_Output.Put_Line('	FOREIGN KEY ('||Con_Columns(cur_rec.table_name, cur_rec.constraint_name)||')');
        DBMS_Output.Put_Line('	REFERENCES '||Lower(v_r_table_name)||' ('||Con_Columns(v_r_table_name, cur_rec.r_constraint_name)||')');
            
        IF cur_rec.delete_rule = 'CASCADE' THEN
            DBMS_Output.Put_Line('		ON DELETE CASCADE');
        END IF;

        IF cur_rec.status = 'DISABLE' THEN
            DBMS_Output.Put_Line('		DISABLE');
        END IF;

        DBMS_Output.Put_Line('	)');
        DBMS_Output.Put_Line('/');
        DBMS_Output.Put_Line('	');
    END LOOP;

END;
/

SET VERIFY ON
SET FEEDBACK ON



	


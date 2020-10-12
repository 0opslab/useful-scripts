-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/fks_ref_table.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for the foreign keys that reference the specified table.
-- Call Syntax  : @fks_ref_table (table-name) (schema)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET LINESIZE 80
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
        WHERE   a.r_constraint_name IN (SELECT  b.constraint_name
                                        FROM    all_constraints b
                                        WHERE   b.table_name       = Upper('&&1')
                                        AND     b.owner            = Upper('&&2')
                                        AND     b.constraint_type IN ('P', 'U') )
        AND     a.owner = Upper('&&2')
        ORDER BY a.table_name, a.constraint_name;

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

    DBMS_Output.Put_Line('PROMPT');
    DBMS_Output.Put_Line('PROMPT Createing Foreign Keys to ' || Upper('&&1'));
    FOR cur_rec IN cu_cons LOOP
        DBMS_Output.Put_Line('ALTER TABLE '||Lower(cur_rec.table_name)||' ADD');
        DBMS_Output.Put_Line('(');
        DBMS_Output.Put_Line('	CONSTRAINT '||Lower(cur_rec.constraint_name));
        DBMS_Output.Put_Line('	FOREIGN KEY ('||Con_Columns(cur_rec.table_name, cur_rec.constraint_name)||')');
        DBMS_Output.Put_Line('	REFERENCES '||Lower('&&1')||' ('||Con_Columns(Upper('&&1'), cur_rec.r_constraint_name)||')');
            
        IF cur_rec.delete_rule = 'CASCADE' THEN
            DBMS_Output.Put_Line('		ON DELETE CASCADE');
        END IF;

        IF cur_rec.status = 'DISABLE' THEN
            DBMS_Output.Put_Line('		DISABLE');
        END IF;

        DBMS_Output.Put_Line(')');
        DBMS_Output.Put_Line('/');
        DBMS_Output.Put_Line('	');
    END LOOP;

END;
/

SET VERIFY ON
SET FEEDBACK ON



	


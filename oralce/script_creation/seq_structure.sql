-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/seq_structure.sql
-- Author       : DR Timothy S Hall
-- Description  : Creates the DDL for the specified sequence, or all sequences.
-- Call Syntax  : @seq_structure (sequence-name or all) (schema-name)
-- Last Modified: 28/01/2001
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF
SET FEEDBACK OFF
PROMPT

DECLARE

    CURSOR cu_seq IS
        SELECT a.sequence_name,
               Decode(a.min_value,NULL,'NOMINVALUE','MINVALUE     ' || a.min_value) min_value,
               Decode(a.max_value,NULL,'NOMAXVALUE','MAXVALUE     ' || a.max_value) max_value,
               a.increment_by,
               Decode(a.cycle_flag,'Y','CYCLE','NOCYCLE') cycle_flag,
               Decode(a.order_flag,'Y','ORDER','NOORDER') order_flag,
               Decode(a.cache_size,0,'NOCACHE','CACHE        ' || a.cache_size) cache_size,
               a.last_number
        FROM   all_sequences a
        WHERE  a.sequence_name  = Decode(Upper('&&1'), 'ALL',a.sequence_name, Upper('&&1'))
        AND    a.sequence_owner = Upper('&&2');
 
BEGIN

    DBMS_Output.Disable;
    DBMS_Output.Enable(1000000);

    FOR cur_seq IN cu_seq LOOP
        DBMS_Output.Put_Line('PROMPT');
        DBMS_Output.Put_Line('PROMPT Creating Sequence ' || cur_seq.sequence_name);
        DBMS_Output.Put_Line('CREATE SEQUENCE ' || Lower(cur_seq.sequence_name));
        DBMS_Output.Put_Line('INCREMENT BY ' || cur_seq.increment_by);
        DBMS_Output.Put_Line('START WITH   ' || cur_seq.last_number);
        DBMS_Output.Put_Line(cur_seq.min_value);
        DBMS_Output.Put_Line(cur_seq.max_value);
        DBMS_Output.Put_Line(cur_seq.cycle_flag);
        DBMS_Output.Put_Line(cur_seq.cache_size);
        DBMS_Output.Put_Line(cur_seq.order_flag);
        DBMS_Output.Put_Line('/');        
        DBMS_Output.Put_Line('	');        
    END LOOP;

END;
/

SET VERIFY ON
SET FEEDBACK ON
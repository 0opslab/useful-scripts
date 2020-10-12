CREATE OR REPLACE PACKAGE string_api AS
-- --------------------------------------------------------------------------
-- Name         : http://www.oracle-base.com/dba/miscellaneous/string_api.sql
-- Author       : DR Timothy S Hall
-- Description  : A package to hold string utilities.
-- Requirements : 
-- Ammedments   :
--   When         Who       What
--   ===========  ========  =================================================
--   02-DEC-2004  Tim Hall  Initial Creation
-- --------------------------------------------------------------------------

-- Public types
TYPE t_split_array IS TABLE OF VARCHAR2(32767);

FUNCTION split_text (p_text       IN  CLOB,
                     p_delimeter  IN  VARCHAR2 DEFAULT ',')
  RETURN t_split_array;

END string_api;
/

SHOW ERRORS


CREATE OR REPLACE PACKAGE BODY string_api AS
-- --------------------------------------------------------------------------
-- Name         : http://www.oracle-base.com/dba/miscellaneous/string_api.sql
-- Author       : DR Timothy S Hall
-- Description  : A package to hold string utilities.
-- Requirements : 
-- Ammedments   :
--   When         Who       What
--   ===========  ========  =================================================
--   02-DEC-2004  Tim Hall  Initial Creation
-- --------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
FUNCTION split_text (p_text       IN  CLOB,
                     p_delimeter  IN  VARCHAR2 DEFAULT ',')
  RETURN t_split_array IS
-- ----------------------------------------------------------------------------
  l_array  t_split_array   := t_split_array();
  l_text   CLOB := p_text;
  l_idx    NUMBER;
BEGIN
  l_array.delete;

  IF l_text IS NULL THEN
    RAISE_APPLICATION_ERROR(-20000, 'P_TEXT parameter cannot be NULL');
  END IF;

  WHILE l_text IS NOT NULL LOOP
    l_idx := INSTR(l_text, p_delimeter);
    l_array.extend;
    IF l_idx > 0 THEN
      l_array(l_array.last) := SUBSTR(l_text, 1, l_idx - 1);
      l_text := SUBSTR(l_text, l_idx + 1);
    ELSE
      l_array(l_array.last) := l_text;
      l_text := NULL;
    END IF;
  END LOOP;
  RETURN l_array;
END split_text;
-- ----------------------------------------------------------------------------

END string_api;
/

SHOW ERRORS


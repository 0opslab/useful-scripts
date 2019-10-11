-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/free_space.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays space usage for each datafile.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @free_space
-- Last Modified: 15-JUL-2000
-- -----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
SET PAGESIZE 1000
SET LINESIZE 255
SET FEEDBACK OFF

SELECT Substr(df.tablespace_name,1,20) "Tablespace Name",
       Substr(df.file_name,1,40) "File Name",
       Round(df.bytes/1024/1024,2) "Size (M)",
       Round(e.used_bytes/1024/1024,2) "Used (M)",
       Round(f.free_bytes/1024/1024,2) "Free (M)",
       Rpad(' '|| Rpad ('X',Round(e.used_bytes*10/df.bytes,0), 'X'),11,'-') "% Used"
FROM   DBA_DATA_FILES DF,
       (SELECT file_id,
               Sum(Decode(bytes,NULL,0,bytes)) used_bytes
        FROM dba_extents
        GROUP by file_id) E,
       (SELECT Max(bytes) free_bytes,
               file_id
        FROM dba_free_space
        GROUP BY file_id) f
WHERE  e.file_id (+) = df.file_id
AND    df.file_id  = f.file_id (+)
ORDER BY df.tablespace_name,
         df.file_name;

PROMPT
SET FEEDBACK ON
SET PAGESIZE 18
